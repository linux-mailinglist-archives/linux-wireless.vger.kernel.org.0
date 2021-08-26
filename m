Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB13F85DB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbhHZKvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:51:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38222 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241761AbhHZKvv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:51:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629975064; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wRDjUNngzx8wMiil9WEwX/qFGguTuF8OcepMb62yclE=;
 b=K53gmV33OHG43TFzeIFIJinYrN8oIBX+ij+5dN7kWDWo2H3co/wBmRU+VJi4ONwmFrxl1ItM
 Fc6PH4eIqE+UjxZ6xBJtkPmg1BXMHuS7Pq8pMvqYpX2dJUAWaBYcBR9k8P9wybprS3dxW1pp
 /4ZBWPe2Dhx60ZfICpZuvR6Vh34=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 612771fc825e13c54a9e4124 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 10:50:36
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE2D0C43619; Thu, 26 Aug 2021 10:50:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36EF2C4360D;
        Thu, 26 Aug 2021 10:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Aug 2021 18:50:35 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
Message-ID: <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 16:29, Johannes Berg wrote:
> On Fri, 2021-08-20 at 08:20 -0400, Wen Gong wrote:
>> 
>>  	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
>>  		const struct cfg80211_bss_ies *ies;
>> +		struct ieee80211_bss_conf *bss_conf;
> 
> am I missing where you set this?
sorry, i lost it in v2 patch.
bss_conf = &sdata->vif.bss_conf;
> 
>> +		if (is_6ghz) {
>> +			struct ieee802_11_elems elems;
> 
> This is pretty big, not sure we want it on the stack (causes warnings
> for me in build). Also, if we're doing this anyway, then we can change
> the code above (perhaps as a separate patch) to not do
> cfg80211_find_ext_ie() but rather take it out of the parsed.
will change it.
> 
>> +			u8 i, j = 0;
>> +
>> +			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,
> 
> (line too long)
> 
>> +					       NULL, NULL);
>> +
>> +			if (elems.pwr_constr_elem)
>> +				bss_conf->pwr_reduction = *elems.pwr_constr_elem;
> 
> before using it?
> 
>> +
>> +			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
>> +				     ARRAY_SIZE(elems.tx_pwr_env));
>> +
>> +			for (i = 0; i < elems.tx_pwr_env_num; i++) {
>> +				if (elems.tx_pwr_env_len[i] >
>> +				    sizeof(bss_conf->tx_pwr_env[j]))
>> +					continue;
> 
> I did that in the parsing itself.
> 
>> +
>> +				bss_conf->tx_pwr_env_num++;
>> +				memcpy(&bss_conf->tx_pwr_env[j], elems.tx_pwr_env[i],
>> +				       elems.tx_pwr_env_len[i]);
> 
> You're never resetting any of this for the next connection (if it's not
> 6 GHz for example, or doesn't have any data) - should probably memset
> all the new members to 0 before the "if (is_6ghz)" or so?
> 
it is memset here i this patch:
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -721,6 +721,15 @@ static int ieee80211_assign_vif_chanctx(struct 
ieee80211_sub_if_data *sdata,
                                          
lockdep_is_held(&local->chanctx_mtx));

         if (conf) {
+               if (conf->def.chan->band == NL80211_BAND_6GHZ) {
+                       struct ieee80211_bss_conf *bss_conf;
+
+                       bss_conf = &sdata->vif.bss_conf;
+                       bss_conf->pwr_reduction = 0;
+                       bss_conf->tx_pwr_env_num = 0;
+                       memset(bss_conf->tx_pwr_env, 0, 
sizeof(bss_conf->tx_pwr_env));
+               }
+
                 curr_ctx = container_of(conf, struct ieee80211_chanctx, 
conf);

                 drv_unassign_vif_chanctx(local, sdata, curr_ctx);

> johannes

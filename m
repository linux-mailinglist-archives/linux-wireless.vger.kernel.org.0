Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE22327897
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 08:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhCAHuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 02:50:22 -0500
Received: from z11.mailgun.us ([104.130.96.11]:25813 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhCAHuS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 02:50:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614585078; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4L9wY9dr1AayOLox6DAd4au8Ubv8ZBNxySyyZFR26MY=; b=ofPpGO67Vz2mWZ+ZrQnphhjAcLZrVh+Jek4ECis1RhJY0EjDLsDElMxKwtwByQ3kwhqwLKHy
 4kll/G+uovNTZBJrvFGPnMN8UV+e0rpQ/hns/Gy9eH4MO0uY8XIylKJCCfabif986u7kU2F6
 HCS++5TXiKKKdN++fR+14jkX220=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 603c97ee9e950d0db1e3383e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 07:29:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49F83C433ED; Mon,  1 Mar 2021 07:29:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D508AC433CA;
        Mon,  1 Mar 2021 07:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D508AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Subject: Re: [PATCH iwlwifi-next] iwlwifi: fix 'arithmetic on a pointer to void' errors
References: <alpine.BSF.2.00.2102261651340.72241@ai.fobar.qr>
Date:   Mon, 01 Mar 2021 09:29:43 +0200
In-Reply-To: <alpine.BSF.2.00.2102261651340.72241@ai.fobar.qr> (Bjoern A.
        Zeeb's message of "Fri, 26 Feb 2021 16:52:07 +0000 (UTC)")
Message-ID: <87pn0jcowo.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Bjoern A. Zeeb" <bz@FreeBSD.ORG> writes:

> Compiling the code with clang on FreeBSD complains about:
>   arithmetic on a pointer to void is a GNU extension
>       [-Werror,-Wpointer-arith].
> Cast to (u8 *) for the arithmetic operation and then back to
> the requested type or apply () before casting to avoid errors
> and have a defined behaviour.
>
> Sponsored-by:  The FreeBSD Foundation
> Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>

[...]

> -		range = range + range_size;
> +		range = (void *)((u8 *)range + range_size);

I think "(void *)" is not needed here.

>  static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
>  			     struct iwl_mvm_scan_params *params,
>  			     int type, int uid)
>  {
>  	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
>  	struct iwl_scan_umac_chan_param *chan_param;
>  	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
> -	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
> -		mvm->fw->ucode_capa.n_scan_channels;
> +	void *sec_part = (void *)((u8 *)cmd_data +
> +		sizeof(struct iwl_scan_channel_cfg_umac) *
> +		mvm->fw->ucode_capa.n_scan_channels);

Not needed here as well.

> @@ -151,28 +151,28 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
>  static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
>  				  dma_addr_t addr, u16 len, bool reset)
>  {
>  	void *tfd;
>  	u32 num_tbs;
>
> -	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
> +	tfd = (void *)((u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr);

And not here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

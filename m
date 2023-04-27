Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127F66F0AD4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjD0R0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbjD0R0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 13:26:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B23584
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:26:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so9039879a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682616402; x=1685208402;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY33Zy2xKG7pznRy97ifyf1l4JhUNtMAVtSxPTboBLs=;
        b=WTeY3V+0wUVpik1llbiMCvZaeBae5x0wmMO4047ZVO9vpeyhmDHokfgPFqwNtELke0
         9kh4xJxkH7InLxxwzM99Avrk3cqGgPRXXOCsBe8fvicrev3gUmOyIEHUo5NhBWWuZa+H
         OyDosPW0AKCQyw6G5dCRgk72/tiy48f4brXZSI4cNwzFTi17YKDDuXv/pxlle8n+2YOU
         ZD+shQSckiF0U1ALE9NnAqKDLauFgfS5PTNIKV8ZkFm+z8Wvkr69fWmDmal73kyyUo6n
         qKENqj6c3XJIPVt693Zok6Y3LfBQUJSsiHIQLVK1l0swIv63aGApyzKygFlbTjHczPqm
         Y+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616402; x=1685208402;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CY33Zy2xKG7pznRy97ifyf1l4JhUNtMAVtSxPTboBLs=;
        b=NnYDodmkzINBSCVelX2XV96an39EF8zS2BpfMypE9KvcQtPC67N0AZ99G7GaSaHMwF
         UqnDXJPazS0E0Wjh+jk+jlV/aHDBpEb9eCqMlH7NaK6EI6DQ4yOsnIOSwZ2MN202Oytv
         j5eYkOzZIOEHgY60nhaLiC4K1zwCiy3jjsY80p8SwwH1VLvNf31Rk7suxutkcrbCziIc
         p9EsUgqXCYnCehC3t2wrFGNMjA152k6z9U3+xmfDnKHBIYn1KRY4LtLdgu/DP+xX8O/D
         P7VAjMqaw6FFQHbgbqgHS3wexcbBsV/cpbcibgmrUoz1Cev93Zqja2iHm9wT6TzPUVzK
         DdlQ==
X-Gm-Message-State: AC+VfDxqgomON//qO/qLX4lAnonJ2jpAtNa68wi/tzh9x0U+oMWc22nY
        Ryo4wtgaJifRsdn6Q/O7dAEGeHpmE4Q=
X-Google-Smtp-Source: ACHHUZ5gZ97grfl+M7x7+/jcirktxFCLeNEcffdkJRC2A/NckLprTdQ7RnMEnGWepnXDDkSABtUhOA==
X-Received: by 2002:a17:907:6e16:b0:930:4eba:1640 with SMTP id sd22-20020a1709076e1600b009304eba1640mr2395220ejc.38.1682616401995;
        Thu, 27 Apr 2023 10:26:41 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b0094f3c281b34sm9853685ejb.196.2023.04.27.10.26.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 10:26:41 -0700 (PDT)
Message-ID: <6bc05de3-42ed-2f0a-188b-8dc0297aee5d@gmail.com>
Date:   Thu, 27 Apr 2023 10:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   James Prestwood <prestwoj@gmail.com>
Subject: sending disassociate/deauth frames to prior BSS after FT/roam?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm tracking down an issue with APs appearing to think a client is still 
associated after it FT roams to another AP. I'll spare everyone the 
details but it got me wondering if a disassociate/deauth frame was 
getting sent to the prior AP by the kernel when reassociating. Following 
the mac80211 logic starting in ieee80211_mgd_assoc():

if (ifmgd->associated) {
	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];

	sdata_info(sdata,
		   "disconnect from AP %pM for new assoc to %pM\n",
		   ifmgd->bssid, req->bss->bssid);
	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
			       WLAN_REASON_UNSPECIFIED,
			       false, frame_buf);

	ieee80211_report_disconnect(sdata, frame_buf,
				    sizeof(frame_buf), true,
				    WLAN_REASON_UNSPECIFIED,
				    false);
}

I noticed here the 'tx' argument to ieee80211_set_disassoc() is false. 
Inside ieee80211_set_disassoc() that I see:

if (tx || frame_buf) {
	/*
	 * In multi channel scenarios guarantee that the virtual
	 * interface is granted immediate airtime to transmit the
	 * deauthentication frame by calling mgd_prepare_tx, if the
	 * driver requested so.
	 */
	if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
	    !ifmgd->have_beacon) {
		drv_mgd_prepare_tx(sdata->local, sdata, &info);
	}

	ieee80211_send_deauth_disassoc(sdata, ifmgd->bssid,
				       ifmgd->bssid, stype, reason,
				       tx, frame_buf);
}

Where 'tx' (false) is then passed to ieee80211_send_deauth_disassoc(). 
This then builds the frame but doesn't actually send it. I tried finding 
something in the spec about sending a disassociate/deauth when doing FT, 
but can't seem to identify any requirement of that. Logically I would 
expect a disassociate/deauth frame since thats what the client is 
doing... Maybe someone has insight into this?

Overall its a rare issue and the clients are able to roam just fine many 
times. But occasionally the APs exhibit this behavior of thinking the 
client is still connected and it (possibly) causes other connectivity 
issues once those APs react.

Thanks,
James

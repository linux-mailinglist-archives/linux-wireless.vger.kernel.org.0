Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289BC43E0B2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJ1MWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 08:22:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45483 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 08:22:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635423576; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xMeIdN2FZQff6DezX7QGHdbUz4JRZYLaaTuPo1KS7vo=; b=QM56AtcFF4YHaf2NRZesmiFPbBLp319C48pWYxrrVYkWwuqQ3I/54mUUhajo79k7gYBzoube
 vZJja1+wQKM23LsR3SdsvqrIMIl3ZeIZcMovaxNOnTcMaqwElNhwyvHjOqkPeRsmZUy0xoH0
 2dnBOUukm4Bd/KigsHMVohfFaRU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 617a9557f6a3eeacf9c1ce49 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 12:19:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E94B6C43616; Thu, 28 Oct 2021 12:19:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA1DCC43460;
        Thu, 28 Oct 2021 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EA1DCC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     mpubbise@codeaurora.org
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        cjhuang=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] ath11k: enable power save in station mode
References: <20211011190625.4463-1-cjhuang@codeaurora.org>
        <f4457c0027a70d996eb5930a334a9832@codeaurora.org>
Date:   Thu, 28 Oct 2021 15:19:30 +0300
In-Reply-To: <f4457c0027a70d996eb5930a334a9832@codeaurora.org> (mpubbise's
        message of "Thu, 28 Oct 2021 10:53:34 +0530")
Message-ID: <87wnlx4a0d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mpubbise@codeaurora.org writes:

> On 2021-10-12 00:36, Carl Huang wrote:
>> Enable power save in station mode.
>>
>> Run "iw dev wls1 set power_save off",  check there is no NULL Data
>> frame
>> from sniffer. Run "iw dev wls1 set power_save on", check there is NULL
>> Data frame from sniffer.
>>
>> Tested-on: QCA6390 hw2.0 PCI
>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>>
>> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

[...]

>> +int ath11k_wmi_set_psmode(struct ath11k *ar, u32 vdev_id,
>> +			  enum wmi_sta_ps_mode psmode)
>> +{
>> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
>> +	struct wmi_sta_powersave_mode_cmd *cmd;
>> +	struct sk_buff *skb;
>> +	int ret;
>> +
>> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	cmd = (struct wmi_sta_powersave_mode_cmd *)skb->data;
>> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
>> +				     WMI_TAG_STA_POWERSAVE_MODE_CMD) |
>> +			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
>> +
>> +	cmd->vdev_id = vdev_id;
>> +	cmd->sta_ps_mode = psmode;
>> +
>> +	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
>> +		   "WMI set sta ps vdev_id %d ps %d\n",
>> +		   vdev_id, psmode);
>> +
>> +	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_POWERSAVE_MODE_CMDID);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to send WMI_STA_POWERSAVE_PARAM_CMDID");
>> +		dev_kfree_skb(skb);
>> +	}
>> +
>> +	return ret;
>> +}
>
> An API which does this is already present in ATH11K, you may have to
> take a look at ath11k_wmi_pdev_set_ps_mode() ?

Good catch, I'll fix this in v2.

And please do trim your replies, quotes over 200 lines long make it hard
to read.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

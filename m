Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F664A659
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 18:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLLR4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiLLR4t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 12:56:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723125FA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 09:56:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r26so14007054edc.10
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZM65wTdJ5glEvakN2TcZKw/j2lkBxYDDYDJL8+UVvw=;
        b=NkQD4rBZtzsYer7dmSbRSh7Wg/ZN4WxUOoVfO3MFiQlUZosjuiYnKLTcMMUQcb0MZW
         W3bYBVS87Drm0HJaiLw1/f3Kzxj2kExXKH/TBoX/uFaH2ToGyeNbBdAMRqW4ql8X78cJ
         I77I25uGtGRrOWNxc05vdKXvXMUboPacKslDY5DcJcVGLauMRyJvVMC/sDpX4i0Hx2QJ
         e0blIVtLjsO+2zHniai88/Ips65HoGuqLdo4uwL+oPE669i/rcgWFR3raeC/I5k0PanT
         OzD6szIG/a7FGlfKz2w3g+nG7OouQfYDWSt7sSWh+MzkYbmhphI8bJ4rEv1tyZ0DaAVz
         +k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZM65wTdJ5glEvakN2TcZKw/j2lkBxYDDYDJL8+UVvw=;
        b=7a7Tx98xSKQjeqDEJ3uzDb0DN8CGXgBtZDzHKFf+zlaZTj4DVgiI/fP1ogM4IDlzNy
         fw0AFFyQXmqCWgb0SvurLVfSelRrREBj1wfX5ISxHZjWfnamL5FHQ81mK5HtM3c2JjwC
         ByStYhP2+BG/1YhXslsk96dpmTMAdcRmtnsrqDrPvo6KJ8L+DtvRZyZl6MZJFdW84Yyy
         G+mllz3nma+JoIpCJd6of+2t9CDRHxAT/sYDWDNAitfdBmT3ujbtTP1M8pdY5DEVnuMS
         PH9Hq3voyPFe3hgr6u2xpui+xR7MJ4Uh73kLJUzb4fiv+OZpYQWOaTdPque83yGhMhhe
         CMiA==
X-Gm-Message-State: ANoB5pnbl7f/dTEORWW4s9erraZkA+papwenR+pOmsUD3Duw3DI3RMKR
        Yt6eIfDpzVVCbXtBjkA/xpo=
X-Google-Smtp-Source: AA0mqf6+PPKY400mWBCTyUqWt2nRYJCxND+21Xnj280t3ZTNNCxjd2dbO3wha/Ju0hLGebGdjs7vsg==
X-Received: by 2002:a05:6402:5305:b0:462:6ace:34cb with SMTP id eo5-20020a056402530500b004626ace34cbmr14543539edb.0.1670867799873;
        Mon, 12 Dec 2022 09:56:39 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402114e00b004589da5e5cesm4004642edw.41.2022.12.12.09.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 09:56:39 -0800 (PST)
Message-ID: <9646ac2d-5993-dbae-4625-f81d537d3fbe@gmail.com>
Date:   Mon, 12 Dec 2022 19:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] wifi: rtl8xxxu: Add rate control code for RTL8188EU
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <00c4bd4a-10e0-02e6-4e09-f450909414ac@gmail.com>
 <ad8e37cf-3653-acde-5259-84768e3d3c8e@gmail.com>
 <9d717c58f61149d1ac8b4db889911316@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9d717c58f61149d1ac8b4db889911316@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/12/2022 10:03, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, December 7, 2022 5:49 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>; Andrea Merello
>> <andrea.merello@gmail.com>; Taehee Yoo <ap420073@gmail.com>
>> Subject: [PATCH 2/2] wifi: rtl8xxxu: Add rate control code for RTL8188EU
>>
>> Copied from the newer vendor driver, v5.2.2.4.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> This patch should be applied after my older patch:
>> "[PATCH v4 3/3] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report"
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  39 ++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 600 +++++++++++++++++-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 129 +++-
>>  3 files changed, 738 insertions(+), 30 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> index 9eb9ae03ca81..d620c7a4d3c6 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> 
> [...]
> 
>> @@ -1251,6 +1377,478 @@ static s8 rtl8188e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
>>  	return rx_pwr_all;
>>  }
>>
>> +static void rtl8188e_set_tx_rpt_timing(struct rtl8xxxu_ra_info *ra, u8 timing)
>> +{
>> +	u8 idx = 0;
> 
> no need '=0'
> 
>> +
>> +	for (idx = 0; idx < 5; idx++)
>> +		if (dynamic_tx_rpt_timing[idx] == ra->rpt_time)
>> +			break;
>> +
>> +	if (timing == DEFAULT_TIMING) {
>> +		idx = 0; /* 200ms */
>> +	} else if (timing == INCREASE_TIMING) {
>> +		if (idx < 5)
>> +			idx++;
>> +	} else if (timing == DECREASE_TIMING) {
>> +		if (idx > 0)
>> +			idx--;
>> +	}
>> +
>> +	ra->rpt_time = dynamic_tx_rpt_timing[idx];
>> +}
> 
> [...]
> 
>> +static void rtl8188e_power_training_try_state(struct rtl8xxxu_ra_info *ra)
>> +{
>> +	ra->pt_try_state = 0;
>> +	switch (ra->pt_mode_ss) {
>> +	case 3:
>> +		if (ra->decision_rate >= DESC_RATE_MCS13)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 2:
>> +		if (ra->decision_rate >= DESC_RATE_MCS5)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 1:
>> +		if (ra->decision_rate >= DESC_RATE_48M)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 0:
>> +		if (ra->decision_rate >= DESC_RATE_11M)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	default:
>> +		ra->pt_try_state = 0;
> 
> break;
> 
>> +	}
>> +
>> +	if (ra->rssi_sta_ra < 48) {
>> +		ra->pt_stage = 0;
>> +	} else if (ra->pt_try_state == 1) {
>> +		if ((ra->pt_stop_count >= 10) ||
>> +		    (ra->pt_pre_rssi > ra->rssi_sta_ra + 5) ||
>> +		    (ra->pt_pre_rssi < ra->rssi_sta_ra - 5) ||
>> +		    (ra->decision_rate != ra->pt_pre_rate)) {
>> +			if (ra->pt_stage == 0)
>> +				ra->pt_stage = 1;
>> +			else if (ra->pt_stage == 1)
>> +				ra->pt_stage = 3;
>> +			else
>> +				ra->pt_stage = 5;
>> +
>> +			ra->pt_pre_rssi = ra->rssi_sta_ra;
>> +			ra->pt_stop_count = 0;
>> +		} else {
>> +			ra->ra_stage = 0;
>> +			ra->pt_stop_count++;
>> +		}
>> +	} else {
>> +		ra->pt_stage = 0;
>> +		ra->ra_stage = 0;
>> +	}
>> +
>> +	ra->pt_pre_rate = ra->decision_rate;
>> +
>> +	/* TODO: implement the "false alarm" statistics for this */
>> +	/* Disable power training when noisy environment */
>> +	/* if (p_dm_odm->is_disable_power_training) { */
>> +	if (1) {
>> +		ra->pt_stage = 0;
>> +		ra->ra_stage = 0;
>> +		ra->pt_stop_count = 0;
>> +	}
>> +}
> 
> [...]
> 
>> @@ -5757,6 +5780,42 @@ static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,
>>  	schedule_work(&priv->c2hcmd_work);
>>  }
>>
>> +static void rtl8188e_c2hcmd_callback(struct work_struct *work)
>> +{
>> +	struct rtl8xxxu_priv *priv = container_of(work, struct rtl8xxxu_priv, c2hcmd_work);
>> +	struct device *dev = &priv->udev->dev;
>> +	struct sk_buff *skb = NULL;
>> +	struct rtl8xxxu_rxdesc16 *rx_desc;
>> +
>> +	while (!skb_queue_empty(&priv->c2hcmd_queue)) {
>> +		skb = skb_dequeue(&priv->c2hcmd_queue);
>> +
>> +		rx_desc = (struct rtl8xxxu_rxdesc16 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
>> +
>> +		switch (rx_desc->rpt_sel) {
>> +		case 1:
>> +			dev_dbg(dev, "C2H TX report type 1\n");
>> +
>> +			break;
>> +		case 2:
>> +			dev_dbg(dev, "C2H TX report type 2\n");
>> +
>> +			rtl8188e_handle_ra_tx_report2(priv, skb);
>> +
>> +			break;
>> +		case 3:
>> +			dev_dbg(dev, "C2H USB interrupt report\n");
>> +
>> +			break;
>> +		default:
>> +			dev_warn(dev, "%s: rpt_sel should not be %d\n",
>> +				 __func__, rx_desc->rpt_sel);
> 
> break;
> 
>> +		}
>> +
>> +		dev_kfree_skb(skb);
>> +	}
>> +}
>> +
>>  int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
> 
> [...]
> 
> I admit that I don't quite understand rate control code, so I just review
> surface, but it would be fine if it works fine to you. :-)
> 
> --
> Ping-Ke
> 
> 
Thank you for the review. I'll make the changes.

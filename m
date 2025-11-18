Return-Path: <linux-wireless+bounces-29110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3FC6BD88
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 915AF35665E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA1306491;
	Tue, 18 Nov 2025 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7az9MyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2871FA859
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504524; cv=none; b=Vb7eGs7uOm2mFu937CYQHKyGNdaoYYPT2ziLr1z7ExfGF9JcdaT/j2BAySgNqVYhTPlCEBn+lY5eeai+JycctPL1JEcQ2sHGkM0P/Jw77CZC1k8k7PznwQcTqQjnBrv/8n9Km7V7SVrg8tqVVw9XPdeg7t/49L1TZPnz/rocqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504524; c=relaxed/simple;
	bh=z6yFFwhrHOIxjJWRBkAE7cyvYJWL9aORQeiGelJ5bfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=OB/pdqGUSfp8U6D/G0o/SjfihNO4u87umdPX3SuOzqjGssWHyqXCmBC9vSUze/6B1OWzfgr3hyGKazGo2Z1Rz7GmOw0QN2k0750+FPlAaMIcba3tQ7MFh5CMaNQGsAyYpj+h+omstOuOFhbxppa0gPTVE+Wsh4mUzcTdq9jlSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7az9MyL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735b7326e5so52350266b.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 14:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763504520; x=1764109320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV+Md40IUmCQcjHkc+OBMWNKB5/p6nGJYYGiOm4LLCA=;
        b=V7az9MyLbEAlU0CnzzhjsCWjjsaU2apG5/wj0ly6jMkuX1ULq6KHxjBeFDt0gY3zMp
         LRTK8hja5L4jSdzIJY8FOenG9tH8l6o1XgeJ938aO4hx2gylFXGoIwdihEpzoGpkktrY
         tbXY4CDtgxwXM95vfQIyDFL7rZgSJc6EpARTUhoRTElnySxbVKWDIp8p57emnfT4LcgT
         8W/ijjho8lC1kNodm7Z4KuLW3xZh44jfeMMM1ax9T87aGCQ12OTOFlaPm716f2XObh4q
         aiPGMgerQWi4BQMVtzMScWpRm9gXuJhc9k4EMIsqt/Cnvvo7xdJf+SSuKz3z6p0gta49
         g3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763504520; x=1764109320;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vV+Md40IUmCQcjHkc+OBMWNKB5/p6nGJYYGiOm4LLCA=;
        b=iZEx0YaGWtqxSqweC7CBdWwO2JkOQy9BIV8rNZTMeVbqKDpuZSVPiFKKV0S/cqVoRL
         +ZdHk+9cNaF6J+W9Tjr92WoMy6+aDJGawwa0MGvn1Gckoi3fIpfOlaYvpRK0beDuwdaM
         nMGaKNYt6bPIl9JjOQNmWnF88t6pnasa917ZXYp7+tONLuUFXhIzGHwYy4lewfXOOOHc
         /6wrzfp4KeJWhIOPiZaGXOB7hshzg07kQZ4rA3V2GbZFt7yBpWS/LmezzhhJ08y7Yeog
         xC0PuagwRw+oHIV8+Xv7XBkskGyBIMsBwL9jqOdlwh4yJKfxjcv8lr2GFuhT1mW/pxwu
         BSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPlWXEIxpWJzaJSaAVoAThPVM8Qh66jUv3GQ9lkmskrQUdmw0192S2HEl3yZHAVjJxg4cZ50dZqiyW51Eudg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwspkZkX2ocmj0WCs7CQQ5WSkmwSTb+dMcbPPeN1psxA7Mc0HSV
	TRwmDQuQ7virbyLK3DI10L1Kd6QEleOAMwu62UQTAj340nuAHKrnIaKi
X-Gm-Gg: ASbGnctc0zGzldNyVj61WMSady3fnQICD9VIATdfoadInmdVI8Ja3l591QOHG+FX5H5
	GZlgFmizf/2BWBnB2BouIlU9p0Clh4yqHDfTPhWZhlvgijvj5irbb9aKJfGcMdiunjcSOhdFU0e
	CzkMMBQR6FpWrq10P9EJLEckBo2WyVvT2KsUsbt9wkBl4ZMF5fPY1yd9KnEdeHkwo0+diWWO1xu
	y7rpTHeockkWqPWPIlIJv7CWdWBWvpuGGs1IsA8/m45Z80C3nNuAKxUEF9HDGuwgl3DDZSyrblO
	U+UGSOpOtmxkLFZkVWA8IXsKSaaOQjnNojkM92zE2DdR/PnrbG4ztNB8Fj0WvvKwTluc1R8+h0O
	0DpO1cXvU7gddUmCGARxfl6QbVpd2k7ZP6SRA8q8iEq2cwfKLs4kijKW31j/ArQPMkkO0fA4A0p
	6j7yh6RvxIR/vuGJE1f30=
X-Google-Smtp-Source: AGHT+IFDQ63tlKhcluodzsph2mBr8tR7BTNtLBvzXQ5TqodVtLWFMCvNoqrAYQAPyWDU0pDf2BBRnA==
X-Received: by 2002:a17:907:97d0:b0:b72:dcda:fe5a with SMTP id a640c23a62f3a-b763810c060mr36605566b.5.1763504520280;
        Tue, 18 Nov 2025 14:22:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41f1sm1468489266b.23.2025.11.18.14.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 14:21:59 -0800 (PST)
Message-ID: <9e053524-3ab0-4d8f-9c08-1a2d0caa1892@gmail.com>
Date: Wed, 19 Nov 2025 00:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating channel
 be last
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
 <5b0834f55d91469282a0f42c651d5441@realtek.com>
Content-Language: en-US
In-Reply-To: <5b0834f55d91469282a0f42c651d5441@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2025 04:17, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Scanning can be offloaded to the firmware. To that end, the driver
>> prepares a list of channels to scan, including periodic visits back to
>> the operating channel, and sends the list to the firmware.
>>
>> When the channel list is too long to fit in a single H2C message, the
>> driver splits the list, sends the first part, and tells the firmware to
>> scan. When the scan is complete, the driver sends the next part of the
>> list and tells the firmware to scan.
>>
>> When the last channel that fit in the H2C message is the operating
>> channel something seems to go wrong in the firmware. It will
>> acknowledge receiving the list of channels but apparently it will not
>> do anything more. The AP can't be pinged anymore. The driver still
>> receives beacons, though.
>>
>> One way to avoid this is to split the list of channels before the
>> operating channel.
>>
>> Affected devices:
>>
>> * RTL8851BU with firmware 0.29.41.3
>> * RTL8832BU with firmware 0.29.29.8
>> * RTL8852BU with firmware 0.29.29.8

I made a mistake here. It should be:

RTL8851BU
RTL8832BU
RTL8852BE

The report about the RTL8852BE came from a user who doesn't have the
card anymore, unfortunately.

Actually, since I wrote that commit message I acquired RTL8851BE and
I can reproduce the problem with that.

> 
> We don't see this problem with the same firmware on RTL8852BE and RTL8852CE,
> and I'd spend some time to check if this impact scan time. Or could you share?
> 

I tested with RTL8832AU and RTL8832CU, which work fine even without
this patch. The scans take about the same time with and without this
patch.

RTL8832CU without the patch:

[2025-11-18 23:17:37.481439]: wlp3s0f3u4 (phy #17): scan started
[2025-11-18 23:17:43.965465]: wlp3s0f3u4 (phy #17): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""
[2025-11-18 23:29:22.624860]: wlp3s0f3u4 (phy #17): scan started
[2025-11-18 23:29:29.129461]: wlp3s0f3u4 (phy #17): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""
[2025-11-18 23:31:19.535787]: wlp3s0f3u4 (phy #17): scan started
[2025-11-18 23:31:26.054462]: wlp3s0f3u4 (phy #17): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""

6.48
6.50
6.51 seconds

RTL8832AU without the patch:

[2025-11-18 23:05:47.163418]: wlp3s0f3u4 (phy #15): scan started
[2025-11-18 23:05:53.690694]: wlp3s0f3u4 (phy #15): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""
[2025-11-18 23:09:37.668990]: wlp3s0f3u4 (phy #15): scan started
[2025-11-18 23:09:44.178517]: wlp3s0f3u4 (phy #15): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""
[2025-11-18 23:10:42.260908]: wlp3s0f3u4 (phy #15): scan started
[2025-11-18 23:10:48.810650]: wlp3s0f3u4 (phy #15): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""

6.52
6.50
6.54 seconds

RTL8832CU with the patch:

[2025-11-18 23:38:50.296919]: wlp3s0f3u4 (phy #18): scan started
[2025-11-18 23:38:56.822416]: wlp3s0f3u4 (phy #18): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""
[2025-11-18 23:41:21.157569]: wlp3s0f3u4 (phy #18): scan started
[2025-11-18 23:41:27.675412]: wlp3s0f3u4 (phy #18): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""
[2025-11-18 23:45:05.087628]: wlp3s0f3u4 (phy #18): scan started
[2025-11-18 23:45:11.615630]: wlp3s0f3u4 (phy #18): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415, ""

6.52
6.51
6.52 seconds

RTL8832AU with the patch:

[2025-11-19 00:03:04.643389]: wlp3s0f3u4 (phy #20): scan started
[2025-11-19 00:03:11.183441]: wlp3s0f3u4 (phy #20): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""
[2025-11-19 00:08:56.944636]: wlp3s0f3u4 (phy #20): scan started
[2025-11-19 00:09:03.504852]: wlp3s0f3u4 (phy #20): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""
[2025-11-19 00:10:10.207836]: wlp3s0f3u4 (phy #20): scan started
[2025-11-19 00:10:16.766985]: wlp3s0f3u4 (phy #20): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""

6.54
6.56
6.55 seconds

> Otherwise, it looks good to me, so give my ACK in advance
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 
>>
>> https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> I didn't think a workaround would be needed in the kernel but 6.18
>> will be out soon and people still have this problem.
>> ---
>>  drivers/net/wireless/realtek/rtw89/fw.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
>> index 96f0463e66d6..c35317abc7f5 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> @@ -7709,6 +7709,13 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
>>         INIT_LIST_HEAD(&list);
>>
>>         list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
>> +               /* The operating channel (tx_null == true) should
>> +                * not be last in the list, to avoid breaking
>> +                * RTL8851BU and RTL8832BU.
>> +                */
>> +               if (list_len + 1 == RTW89_SCAN_LIST_LIMIT_AX && ch_info->tx_null)
>> +                       break;
>> +
>>                 list_move_tail(&ch_info->list, &list);
>>
>>                 list_len++;
>> --
>> 2.51.1
> 



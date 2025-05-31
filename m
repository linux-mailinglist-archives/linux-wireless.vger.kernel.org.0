Return-Path: <linux-wireless+bounces-23518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7BAC9CC8
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB2E3AB7E1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722C187876;
	Sat, 31 May 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLEn56Ih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505415ECD7
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725035; cv=none; b=Rut5hOatg4qpRJMqW61J8Lu4F+WB4V+yWZRnZqUQDq5qnsuJxBfu0WjYXnv8M4vHurLCsIsTHnDVqwms6J0AkU8v4jAOhwnkRmBXdVpkwVXHl1RWNStRA8Ze4CroBvAFPk6cS+fYcuCSRKZ/wp5y8Eoq1ZkrcJUQJ17QJXEZzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725035; c=relaxed/simple;
	bh=dZmbszzTesgGan/esAB9eJpPp0Abrn+egK4H44udmoM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=AsRcyqZOiYKH2XJb3MbLv0PDuapHIEPZizIRkS8OTV9ugRCM8MOfGMrWbOepEdUeUgROD2fHXhuXwxTuXIaaNa9XaJJdBzdLIlwib5qPydaw1kEq3n3wQIHLxUkOCjv8wN/sIURJfET3ik1KKTz1XVaG7Gn0GrIbVyMSfyceNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLEn56Ih; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so22565095e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748725031; x=1749329831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCtRYMfCn6UQjY6dQJMDR1SoooBSVD/z/Mg23D2s3oQ=;
        b=XLEn56IhrgvJqoQcofw0cGPNG7PtxSJHabXkdaK5H60hL3+sCewr2i0UCxhUaCsuvM
         Z+wzjUxBWt0Zr3sUSliOCqejb+1MG67QghZrw80WK74W8aYf2+l/e8Xnnj1HggX2YQL+
         MUZHRfFLJjyG9L2J3tbnuiaCn64p849EGpDfQEw7La4pSq1MzZab2hwOZOdCCdr3R8tu
         khOIa9i/hvIaZDrlchpkZIQ/Ql/FEERB8UlnMCNsHXQNqZR0nJ3nhPzy+3B4lsinbGgE
         XCnx5HkmfrX2qY22FfQDb4keWvJcYXqOJMlDChBOgryj1TBCLpxYsGLzJD2FZDJU7MPp
         Njnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748725031; x=1749329831;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCtRYMfCn6UQjY6dQJMDR1SoooBSVD/z/Mg23D2s3oQ=;
        b=xBxzlziPFBPE2zrwuXMCJbE9YNEoA2ghpYeJfac87TWlbs0rDKE8Kh5YflVl66pWHq
         jZZQbn0GGjmPutplPE7g16CrBCV0ahupEe+PT26qYSuxxzJsvH2Xb8ITMDx3buPiidjt
         N6MioOqUvPK/t9ykvfNkJ2344I+66sNVmOSrnmEu54oi6Iu4kYqooJZGIah1Lu+3g/gT
         aXRz9tdC7QWbQu/PQQ00MoFT3tnPEKJcrVOTNOp4zHjwWMasVnBwp3EIr6idWaHgvZa3
         Fo8ic8slAQxbAGjC/PGw+VCgT0ccKTqdjRrECBoOAnlgIGWRUQdpYA/1sfMGEuXYPxiY
         zjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEzqiD2ZbAa+78hfl024m1ejyoSTnd66jMf2uc91+2GY9t9KoOl/0i66Fgf0dNWL9oE9fgPeQ4fWNdbfZXiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6MAzkYY0IDHQ+HChMQAVoex+i8b72Kk2uHIb3LJqapkZzHhI
	DUU8IRiIpQKViJbq3WEaFymgut9IrTgTS5BO6w6SfL5lDsD/Vebd2tMd
X-Gm-Gg: ASbGncvSFu1rLrXtBHJyL6YYMVyD7ayQcuCV/dB22PfysQw5ZpWSkSy4MySm/rbiNhz
	7JEx2FpSCqldG0DglwOr3RZ9c2Tj0hV1ZKMILYpKQrcbrJeBOdkAVx5i6itoWLvaG2UTmDPDOXQ
	i/PMusp1qC6SV6LGdTCOsA9rH6k5JDHZckVKez+mu1XHbtIQ+sCxfKCrQm7wU6bZ55pKXXg3nIO
	gwB7kp1snq0D/DXI4kwv+sgpyiOt9YuIOE3bBYZoYz2ns4bUAXjdGlgZ/ewKXfTDGFASBNtCaJ9
	AnQasTuQXubG+1X7rHoADQXGfcwWjOsMPsGWhGuVj+iwLhMVyeFDtqImb9Y=
X-Google-Smtp-Source: AGHT+IFh9TSRGG+bFkdh3J7Zbi+n422Mg96eR6DbUOM8xp0A5P5jdgd5++z5V1hj3OmzwhHANeZSEA==
X-Received: by 2002:a05:600c:3593:b0:450:cfcb:5c83 with SMTP id 5b1f17b1804b1-450d888c2cfmr70909575e9.30.1748725031186;
        Sat, 31 May 2025 13:57:11 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0577sm60586955e9.20.2025.05.31.13.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 13:57:10 -0700 (PDT)
Message-ID: <a30a4c25-6821-474b-8e67-0f627ff2be88@gmail.com>
Date: Sat, 31 May 2025 23:57:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
 <54b050dc237e46fcb96576e19451ae97@realtek.com>
 <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
 <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
 <14ed20822a1e4890a30965123825cb5f@realtek.com>
Content-Language: en-US
In-Reply-To: <14ed20822a1e4890a30965123825cb5f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/05/2025 09:29, Ping-Ke Shih wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>> On 13/05/2025 06:12, Ping-Ke Shih wrote:
>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>> Add hfc_param_ini_usb to struct rtw89_chip_info. For now initialise it
>>>>> only for RTL8851B.
>>>>>
>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>
>>>>> +
>>>>> +static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_usb[] = {
>>>>> +       [RTW89_QTA_SCC] = {rtw8851b_hfc_chcfg_usb, &rtw8851b_hfc_pubcfg_usb,
>>>>> +                          &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
>>>>
>>>> [RTW89_QTA_WOW] is missing. I'm not sure if current can handle this correctly.
>>>> Could you try to do WoWLAN with USB? At least, it shouldn't crash.
>>>>
>>>
>>> RTW89_QTA_WOW is missing because I didn't find an equivalent in
>>> enum mac_ax_qta_mode in the vendor driver.
>>
>> Yes, vendor driver doesn't have that. As I know, it does some modifications
>> from original normal operation quota, such as RTW89_QTA_SCC, because we want
>> constant definition in upstream driver. I will check internally and get back
>> to you how it should be for USB devices.
> 
> The main function to get QTA_WOW is redu_wowlan_rx_qta(). 
> 
> Take RTL8851BE as an example, 
> 
> Based on RTW89_QTA_SCC:
>   cfg->ple_size->pge_size =>rtw89_mac_size.ple_size6
>   =>.ple_size6 = {RTW89_PLE_PG_128, 496, 16,},
>   rdu_pg_num = PLE_QTA_PG128B_12KB = 96
> 
> QTA6:
>   .ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,}, //min
>   .ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,}, //max
>                                        ^^^^
>   qta_min = 89
>   qta_max = 229
> 
>   new_qta = (qta_max - qta_min) < rdu_pg_num ?
>           qta_min : (qta_max - rdu_pg_num);
>         = 229 - 96 = 133
> 
> QTA7:
> 
>   .ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,}, //min
>   .ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,}, //max
>                                            ^^^^
> 
>   qta_min = 0 
>   qta_max = 0
> 
>   new_qta = (qta_max - qta_min) < rdu_pg_num ?
>           qta_min : (qta_max - rdu_pg_num);
>           = 0
> 
> Finally:
> 
>   .ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
>                                               ^^^^^^
> 
> A way is to induce the quota by eyes. Another way is to add debug message
> in vendor driver to show these quota -- this would be much simpler. 
> 
> 

Thank you for the explanation. I calculated the quotas like you showed
above and got WOWLAN to work with RTL8851BU. Well, it goes to sleep
and I can wake it up with a Magic Packet, but there are still problems:

1) "c2h reg timeout" error from rtw89_wow_suspend() ->
rtw89_wow_enable() -> rtw89_wow_enable_trx_post() ->
rtw89_wow_config_mac() -> rtw89_wow_config_mac_ax() ->
rtw89_mac_cpu_io_rx() -> rtw89_fw_msg_reg().

The vendor driver doesn't have this problem.

2) It takes ~250 seconds for the above "c2h reg timeout" error to appear
because rtw89_fw_read_c2h_reg() doesn't take into account that it takes
~250 µs to send a USB control message. It uses read_poll_timeout_atomic()
with a timeout of 1000000 µs and a delay of 1 µs. Changing the delay to
250 µs makes read_poll_timeout_atomic() finish after just 2 seconds.

3) There is a warning when the computer wakes up:

May 28 23:14:59 ideapad2 kernel: ------------[ cut here ]------------
May 28 23:14:59 ideapad2 kernel: WARNING: CPU: 2 PID: 3124 at net/mac80211/iface.c:680 ieee80211_do_stop+0x936/0x950 [mac80211]
May 28 23:14:59 ideapad2 kernel: Modules linked in: ccm rtw89_8852bu(OE) rtw89_8851bu(OE) rtw89_8852b(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_usb(OE) rtw89_core(>
May 28 23:14:59 ideapad2 kernel:  snd_hda_codec mousedev sha512_ssse3 snd_rpl_pci_acp6x snd_acp_pci sha256_ssse3 sha1_ssse3 ee1004 snd_hda_core snd_acp_legacy_common snd_>
May 28 23:14:59 ideapad2 kernel: Unloaded tainted modules: 8851bu(OE):1 [last unloaded: 8851bu(OE)]
May 28 23:14:59 ideapad2 kernel: CPU: 2 UID: 0 PID: 3124 Comm: kworker/u16:31 Tainted: G           OE      6.14.2-arch1-1 #1 51440b8a0cc8bb91764dac94f6c2b53455e5a907
May 28 23:14:59 ideapad2 kernel: Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
May 28 23:14:59 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, BIOS HBCN18WW 08/27/2021
May 28 23:14:59 ideapad2 kernel: Workqueue: async async_run_entry_fn
May 28 23:14:59 ideapad2 kernel: RIP: 0010:ieee80211_do_stop+0x936/0x950 [mac80211]
May 28 23:14:59 ideapad2 kernel: Code: 34 ea e9 92 f9 ff ff 0f b7 f0 48 c7 c7 60 d0 28 c2 e8 9e 1b 3e e9 0f 0b e9 89 f8 ff ff 4c 89 e7 e8 7f f3 ff ff e9 03 fd ff ff <0f> >
May 28 23:14:59 ideapad2 kernel: RSP: 0018:ffff97e05b28ba80 EFLAGS: 00010202
May 28 23:14:59 ideapad2 kernel: RAX: 0000000000000004 RBX: ffff8cc46a388a80 RCX: 0000000000000000
May 28 23:14:59 ideapad2 kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8cc51c4810ec
May 28 23:14:59 ideapad2 kernel: RBP: ffff97e05b28bb20 R08: ffff8cc5783ad200 R09: 000000008010000d
May 28 23:14:59 ideapad2 kernel: R10: 000000008010000d R11: 0000000000000246 R12: ffff8cc51c480900
May 28 23:14:59 ideapad2 kernel: R13: ffff97e05b28bab0 R14: ffff97e05b28bab0 R15: 0000000000000000
May 28 23:14:59 ideapad2 kernel: FS:  0000000000000000(0000) GS:ffff8cc653500000(0000) knlGS:0000000000000000
May 28 23:14:59 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 28 23:14:59 ideapad2 kernel: CR2: 0000000000000000 CR3: 0000000140822000 CR4: 00000000003506f0
May 28 23:14:59 ideapad2 kernel: Call Trace:
May 28 23:14:59 ideapad2 kernel:  <TASK>
May 28 23:14:59 ideapad2 kernel:  ? psi_group_change+0x13b/0x310
May 28 23:14:59 ideapad2 kernel:  ieee80211_stop+0x5b/0x1a0 [mac80211 682e229732a6bfe53cb0bbcde81ec2801d27c374]
May 28 23:14:59 ideapad2 kernel:  __dev_close_many+0xaa/0x150
May 28 23:14:59 ideapad2 kernel:  dev_close_many+0xbe/0x1a0
May 28 23:14:59 ideapad2 kernel:  dev_close+0x6f/0xa0
May 28 23:14:59 ideapad2 kernel:  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211 fca8a1144424bca742e19d88b98aa1afb064fec0]
May 28 23:14:59 ideapad2 kernel:  ieee80211_remove_interfaces+0x4d/0x230 [mac80211 682e229732a6bfe53cb0bbcde81ec2801d27c374]
May 28 23:14:59 ideapad2 kernel:  ? __pfx_wait_rcu_exp_gp+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  ieee80211_unregister_hw+0x4a/0x130 [mac80211 682e229732a6bfe53cb0bbcde81ec2801d27c374]
May 28 23:14:59 ideapad2 kernel:  rtw89_core_unregister+0x3a/0x50 [rtw89_core 6d9cf325b1126b69ab43ddd6b0b9a561d4ea24f8]
May 28 23:14:59 ideapad2 kernel:  rtw89_usb_disconnect+0x53/0xe0 [rtw89_usb 2cf966e0c4b7fe950d436a899adc081e9902c1d8]
May 28 23:14:59 ideapad2 kernel:  usb_unbind_interface+0x90/0x290
May 28 23:14:59 ideapad2 kernel:  device_release_driver_internal+0x19c/0x200
May 28 23:14:59 ideapad2 kernel:  ? __pfx_usb_dev_resume+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  usb_forced_unbind_intf+0x75/0xb0
May 28 23:14:59 ideapad2 kernel:  ? __pfx_usb_dev_resume+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  unbind_marked_interfaces.isra.0+0x59/0x80
May 28 23:14:59 ideapad2 kernel:  usb_resume+0x5a/0x60
May 28 23:14:59 ideapad2 kernel:  dpm_run_callback+0x48/0x150
May 28 23:14:59 ideapad2 kernel:  device_resume+0x140/0x240
May 28 23:14:59 ideapad2 kernel:  async_resume+0x1d/0x30
May 28 23:14:59 ideapad2 kernel:  async_run_entry_fn+0x31/0x140
May 28 23:14:59 ideapad2 kernel:  process_one_work+0x17b/0x330
May 28 23:14:59 ideapad2 kernel:  worker_thread+0x2ce/0x3f0
May 28 23:14:59 ideapad2 kernel:  ? __pfx_worker_thread+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  kthread+0xec/0x230
May 28 23:14:59 ideapad2 kernel:  ? __pfx_kthread+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  ret_from_fork+0x31/0x50
May 28 23:14:59 ideapad2 kernel:  ? __pfx_kthread+0x10/0x10
May 28 23:14:59 ideapad2 kernel:  ret_from_fork_asm+0x1a/0x30
May 28 23:14:59 ideapad2 kernel:  </TASK>
May 28 23:14:59 ideapad2 kernel: ---[ end trace 0000000000000000 ]---

It's this one in ieee80211_do_stop():

	/*
	 * If the interface goes down while suspended, presumably because
	 * the device was unplugged and that happens before our resume,
	 * then the driver is already unconfigured and the remainder of
	 * this function isn't needed.
	 * XXX: what about WoWLAN? If the device has software state, e.g.
	 *	memory allocated, it might expect teardown commands from
	 *	mac80211 here?
	 */
	if (local->suspended) {
		WARN_ON(local->wowlan);

I would like to leave the WOWLAN fixes for later, to keep this set of
patches small.


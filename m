Return-Path: <linux-wireless+bounces-22402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7DAA8665
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98CE18990B5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D11C5490;
	Sun,  4 May 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tc9y/1v6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB815ECDF
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746363054; cv=none; b=IJ7Wywnyi2sDP0x6oJCqGSwk4LwPiO9ycdoD3HD16D+gFkKmSMrdkoNJMN0dXjC7NEuqCBBKKqNZ4MCNKksDY04yqve2j3QD16tWN5QNqOW7dLKs9Q8lTunEf1VJ+ppaH6++4lTqLu8dfSnsHlU0S35jEGoHtPUb3qUzRhEUvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746363054; c=relaxed/simple;
	bh=KU+9Q2sf2elqxmlkywg5UaKeeF4W+MjXIQ/bimyTBeM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=HZUaXTECtD+haPkTOb1Z/u/IHUeCyiookmOztnR0kQVemQrAeuDKGGSygQBQhjy2j45Su0JkyDX+/hhcdd1D33vv9K9FvRaY/N/ySsTlEThXtLD5JKgH4NRRge1RAIfSm7kyoogvNMDDez2cUWE5sJpXsycYCcWPnmYgIUMlrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tc9y/1v6; arc=none smtp.client-ip=66.163.185.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746363045; bh=NOTcye4wrXHyxRjNRnZdhgNsdQjuIqvzPSm16mN+V28=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=tc9y/1v6NgAOVrtc0C51IWA/LzUohrwOCPexOgl/b6tdqnyXCnTnA8iqLQpSnfVkSbGNP9aDxdls+tz/F+47JkASgDeNzUsqvNDqg/5ay9/ycm7Il5hJ/wmgAkRQLClSdNvfI77m5BuXZAaTZHNs9+t/PWNEJUxju/IYyQiomLsJKI4clKpIoKtUMq4EDIHbqaiHjBAxZGHc3P/5/Gpiy+Dhte6lD52OlwrIsjgqd9Nr4vNNZ695pwcqqwtZeVrY0DR6cV/yyHKb6IQaJsUqmFm/tFAX7mS3DI+k3V+Wt9tBPS/vIISkBv3IppLZGQLOKh+9dhWOyiEPjtR+WaY9xg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746363045; bh=3c3YYeT+EBktH4iqSKyxFjzeTdJ8xhA1+ThrtCHVvHz=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=djlr93HDUnw8URoe94ctI2g09fMLNPYebwqYhoJuNtk0YvEUXSkK83/hX6SxEVW33NJf4B1s9Z/TwxSQ0Ch/NLRkSTQtAl61deUajwloR5m/CUk8exLH3Tnhyo8YxuUk5iTwfAWlc+2to6G9ek1zqvo7ZZivFOi8/iUvn50FSRWf7qcOSG5wdyAEvAFJN8YS7FFc10Z+R3e9shZ6lfvEst8SVt6OkSa07efl27HKuot0EIzaP2d39F1xesIU8nRutVqIs4acUpWuZltrptfKFt2ImsHgcTAzxvO2Z2l2M1doKBdzZ7jmjUwY6MYpPdx7ueY0G90t/1XAEG/4SWa2Xw==
X-YMail-OSG: DAoQMbMVM1m_eQ80102u3MeGN3F3zZMzVAZm917mMsqtNEaDiviEi18bNm.ttcB
 O2uyM5Kulcdh5Pr4yHkc41gt4FNs4zQZcdhmtrvW_11JFy8W8hsPRF2C6ijreZPDDNu2R7wK_vlp
 9_w7Rlajt1mTUHSlulQgAPpzdZsPTwm8snLYFMuERbB.rhTCm6sqy4H4v50afVF79wFX6TZqCIO.
 Z1mJ7fhuS1odLIFQa75EV4IFVqz6iKzTIo9vCJb52tXKZU5KkDLiXSS7405nxxeGpxJFUGLCBqVg
 z5eMd9ED.OatQlWFzUlwa.bCy7PI1pYO8ws6.ysN3MubLzJAQevEywLQQHhoipDs5LV.sbAnRGJq
 kAL49wdg6D3KjA2nB4HZF0Pxj9hZWwtaF2NLn2HxuCmb52Ch4uiB0q3Bnvdo3rnuAF9.GO0vcAsW
 e_23Hgn47DfhyeH4PYfFyiY5mKk9KW_IuGcYX9.EWA7Uo24krjcFiWztQIJmpR4OQ4jkugpgIk.j
 oCnRU8M_AP_m9PwTfFvwa3lwRU6OM33EG1rSU8KmnG7TPdOi6y_4oweB.sNpkSifGk8m0V5ASp02
 LVbBLwDxJRZPO5Apqdenu3rxTYoUDIfYeU1WgsDuZraQEFBTqmqck12uf_4RMdlNTvnMCVE2fVSX
 j9sFBRjklog1.W3w03FOEETmv6Lq73_saG9P_Xoc8jjq.S523jvQL1pZdkV_RTR_uajtI_6HNctO
 dgxTJspzGGEMynT0ORce5fa7QHR5jGOn5WtppH8LXSDBWnR3ZvrxmtK4VuYGX4inTg4aig7GamqJ
 b2aSWqlS7CUeUP_58ZsavXMC2VXhfDtNNDWCnZQE6GOYotgyfQ8MSRcKcj8X2r008hRqydH0ZOO2
 lrva_iIbhW7tkTsgRGJ6JS8cbNykNpmry7dRZi2XBd8iLi.rOP1QTYGXxzyfk6.8E4ywOaD.YukF
 wqxfTDcgAk7PzsrtFfNL1sBqCFWrhQuYQybNgWQtNl1guc_QN7JvrEAF3cjttkdPf7tbLcYzZENn
 EgPoy6d.GM2BzMNvYdli29ctUBhzg7GCBzH4L57kTNyjix9ehsxK71BUcBhvrCyGkfQ6WszEI8rK
 6Jms5LyUCUb0ZXC_.xbcDzec64OeGnm86NnIDDiIDKtoXYekRbBmzLjr0wtq6D21t4HLej_9YMLb
 _f_V_AnvXdL91brwNwSnWt7cCkx9cCVJHMQ7lzny_r2ImfaCFqXLckjaDJ4_HfzffUKi42zneshd
 HE8UGFnxB1vU_h3X6og7DqDW2aJLyS1osLObdPOKo70bsmf0Q8riqVBKxpFU.YGNkgAX4jHxWEYx
 Jz2gCSg6DMYvJEdVXp95Cenig5int618f1lDkQMhn_jjOELFGrt0UhQlesmFLYrxgRoMscOgixgR
 dub7ZSuwjBMdRvRAb4ZrLRm_Dh0CQ_FSkqLA7ejOwm6PLEAvWBXM38XFhlYcQjZdVXuxG6nc7YgY
 tJcD3fG5Hd1ZDkFS7x73yXamI0VevIfzlYrS0_2B0HuR0MZkGfBn3Xzk8Fzefk8sO8Sm8sLhQv.P
 I4J03YAufNQEbtNq0KfeT3HXKDjd4GIUzOd2Tl_JnMfu7jhSkyq_DXCE8QiDWlgCEhluuNkU76BA
 kOeFqz927YVEs21mKH4hCZNMbqKFi5zYBEj5D11vyGv.VrBspBF8Kg6ZgnfKa6Kh6xrl4v9OeNLj
 .z9vByqfN6Z0MIbrEokXr7zBJmrc1fq3yuHbPwMek7PjKYtzyuinGGcMJ32q8tVZbNA1nchfeyl9
 mjdbuQ8tjUE77BY2JatX8eLySFxeTXiV3MCc9cwohU7yQUtMXrOJzqsUogxSG_1MCkeCAtp5XFA8
 ebzTpnV0Qx9_pK9tJqUK9t4vxcjlukn0WskZaU4Pnwl4BOZ_XiGrj8rGDt41CFy9BaTW0XY9m3yY
 gS1co0bE0.yObpqqMPqVKKsNaBkbhJF9L6BjghFtLCIbS.acAQt.HNhM8zZPxDgKLmdLxs1jWDK.
 fsltam2WCj4xNU015VAvR84mpFEZbz5D_7vdCw_.sjkAZKkpq_K2h.w0yP_OKDkzciXXJrI_ovVT
 .8QUrs05Z75.V3Qc8vpZjNSnqp.upDRrUvZwaTCutNKgncFmH0.FwTonS1gYacTJI_VWW01X2.BQ
 psQ7I9yNUhsfmwXVMkzKHejivpfqWXWX4V80UDHADAvkcY67.J_vuoTsn0p0wbRd1Dfm9WtUXr7k
 ZiSbKwkOz6w_8IF.aeZcBpEo3mlyNY62ocPYHPMCFozKG66qYy63OOimTrR9I2vctBrIzldae92t
 N
X-Sonic-MF: <veysel.macit@yahoo.com>
X-Sonic-ID: e89f4db9-dd99-494b-b64b-14ddee54da6f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sun, 4 May 2025 12:50:45 +0000
Received: by hermes--production-ir2-858bd4ff7b-86wkp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8912e0ef56b828e96d0aeeec9cb51f8;
          Sun, 04 May 2025 12:10:13 +0000 (UTC)
Message-ID: <5eea68e3-9857-4a6e-92b6-7bbff8016ac0@yahoo.com>
Date: Sun, 4 May 2025 14:10:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Veysel B. Macit" <veysel.macit@yahoo.com>
Subject: panic due to null pointer dereference around
 mt7925_sta_set_decap_offload()
To: linux-wireless@vger.kernel.org
Cc: mingyen.hsieh@mediatek.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <5eea68e3-9857-4a6e-92b6-7bbff8016ac0.ref@yahoo.com>
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo



it is easy to reproduce issue.

with mt7925 ap mode just try to disconnect and several time and it 
occurs occasionally.

[  222.120550] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  222.120585] CPU: 1 UID: 0 PID: 1072 Comm: hostapd Tainted: G        
W  O       6.11.0-24-generic #24~24.04.1-Ubuntu
[  222.120643] Tainted: [W]=WARN, [O]=OOT_MODULE
[  222.120667] Hardware name: Default string Default string/Default 
string, BIOS M6_MAX V0.06 02/19/2025
[  222.120712] RIP: 0010:mt7925_sta_set_decap_offload+0xd3/0x180 
[mt7925_common]
[  222.120778] Code: 00 00 00 b8 01 00 00 00 f3 48 0f bc c0 41 89 c6 3c 
0e 77 b5 49 8d 87 30 02 00 00 48 89 45 b8 49 8b 87 18 06 00 00 41 0f b6 
ce <66> 83 78 98 00 74 6d 48 63 c1 80 f9 0e 77 7b 49 8b 84 c7 a0 05 00
[  222.120858] RSP: 0018:ffff9cb5810f73a8 EFLAGS: 00010293
[  222.120890] RAX: 0000000000000000 RBX: ffff8918508c2020 RCX: 
0000000000000000
[  222.120927] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[  222.120963] RBP: ffff9cb5810f7400 R08: 0000000000000000 R09: 
0000000000000000
[  222.120999] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff89185feb9d38
[  222.121034] R13: 0000000000000001 R14: 0000000000000000 R15: 
ffff8918421b8a98
[  222.121070] FS:  00007d8ff3952740(0000) GS:ffff891bafa80000(0000) 
knlGS:0000000000000000
Oops#1 Part4
[  222.121116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  222.121147] CR2: ffffffffffffff98 CR3: 00000001013aa000 CR4: 
0000000000f50ef0
[  222.121185] PKRU: 55555554
[  222.121205] Call Trace:
[  222.121224]  <TASK>
[  222.121245]  ? show_regs+0x6c/0x80
[  222.121278]  ? __die+0x24/0x80
[  222.121304]  ? page_fault_oops+0x96/0x1b0
[  222.121336]  ? kernelmode_fixup_or_oops.isra.0+0x69/0x90
[  222.121373]  ? __bad_area_nosemaphore+0x1a1/0x2d0
[  222.121404]  ? radix_tree_lookup+0xd/0x20
[  222.121434]  ? start_flush_work+0x227/0x2e0
[  222.121468]  ? bad_area_nosemaphore+0x16/0x30
[  222.121496]  ? do_kern_addr_fault+0x78/0xa0
[  222.121524]  ? exc_page_fault+0x1b0/0x1c0
[  222.121557]  ? asm_exc_page_fault+0x27/0x30
[  222.121590]  ? mt7925_sta_set_decap_offload+0xd3/0x180 [mt7925_common]
[  222.121647]  ? mt7925_sta_set_decap_offload+0x50/0x180 [mt7925_common]
[  222.121706]  drv_sta_set_decap_offload+0x98/0x1e0 [mac80211]
[  222.122015]  ieee80211_check_fast_rx+0x315/0x420 [mac80211]
[  222.122301]  _sta_info_move_state+0x38e/0x3f0 [mac80211]
[  222.122551]  sta_info_move_state+0x13/0x20 [mac80211]
[  222.122798]  sta_apply_auth_flags.isra.0+0x5a/0x1e0 [mac80211]
[  222.123082]  sta_apply_parameters+0x26c/0x350 [mac80211]
[  222.123362]  ieee80211_add_station+0xde/0x1a0 [mac80211]
[  222.123615]  nl80211_new_station+0x4e3/0x780 [cfg80211]
[  222.123839]  genl_family_rcv_msg_doit+0xf7/0x160
[  222.123873]  genl_family_rcv_msg+0x182/0x250
[  222.123901]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
[  222.124107]  ? __pfx_nl80211_new_station+0x10/0x10 [cfg80211]
Oops#1 Part3
[  222.124314]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
[  222.124517]  genl_rcv_msg+0x4c/0xb0
[  222.124538]  ? __pfx_genl_rcv_msg+0x10/0x10
[  222.124561]  netlink_rcv_skb+0x5a/0x110
[  222.124588]  genl_rcv+0x28/0x50
[  222.124606]  netlink_unicast+0x245/0x390
[  222.124633]  netlink_sendmsg+0x213/0x470
[  222.124661]  ____sys_sendmsg+0x3a8/0x410
[  222.124688]  ___sys_sendmsg+0x9a/0xf0
[  222.124718]  __sys_sendmsg+0x89/0xf0
[  222.124742]  __x64_sys_sendmsg+0x1d/0x30
[  222.124765]  x64_sys_call+0x912/0x25f0
[  222.124791]  do_syscall_64+0x7e/0x170
[  222.124816]  ? __sys_setsockopt+0x76/0xe0
[  222.124842]  ? aa_sk_perm+0x46/0x240
[  222.124866]  ? syscall_exit_to_user_mode+0x4e/0x250
[  222.124895]  ? copy_from_sockptr_offset.constprop.0+0x24/0x30
[  222.124924]  ? do_sock_setsockopt+0xbe/0x190
[  222.124950]  ? __sys_setsockopt+0x76/0xe0
[  222.124975]  ? syscall_exit_to_user_mode+0x4e/0x250
[  222.125003]  ? do_syscall_64+0x8a/0x170
[  222.125026]  ? syscall_exit_to_user_mode+0x18d/0x250
[  222.125058]  ? do_syscall_64+0x8a/0x170
[  222.125083]  ? __rseq_handle_notify_resume+0x36/0x70
[  222.125112]  ? irqentry_exit_to_user_mode+0x43/0x250
[  222.126008]  ? irqentry_exit+0x43/0x50
[  222.126852]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  222.127704]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  222.128549] RIP: 0033:0x7d8ff312c004
[  222.129383] Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 
0f 1f 44 00 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
Oops#1 Part2
[  222.130251] RSP: 002b:00007ffcb5182188 EFLAGS: 00000202 ORIG_RAX: 
000000000000002e
[  222.131128] RAX: ffffffffffffffda RBX: 00005632b6a8b4e0 RCX: 
00007d8ff312c004
[  222.132006] RDX: 0000000000000000 RSI: 00007ffcb51821c0 RDI: 
0000000000000005
[  222.132881] RBP: 00007ffcb51821b0 R08: 0000000000000004 R09: 
00000000000000f0
[  222.133745] R10: 00007ffcb51822cc R11: 0000000000000202 R12: 
00005632b6ae94c0
[  222.134602] R13: 00005632b6a8b3f0 R14: 00007ffcb51821c0 R15: 
00007ffcb51822cc
[  222.135452]  </TASK>
[  222.136280] Modules linked in: cmac ccm snd_sof_pci_intel_tgl 
snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel 
soundwire_cadence qrtr snd_sof_intel_hda_common snd_sof_intel_hda_mlink 
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof 
x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi snd_sof_utils 
snd_soc_hdac_hda aic8800_fdrv(O) snd_soc_acpi_intel_match 
snd_hda_codec_realtek soundwire_generic_allocation snd_hda_codec_generic 
snd_soc_acpi snd_hda_scodec_component soundwire_bus snd_soc_avs 
snd_soc_hda_codec snd_hda_ext_core snd_soc_core coretemp snd_compress 
ac97_bus snd_pcm_dmaengine kvm_intel snd_hda_intel kvm snd_intel_dspcfg 
bridge snd_intel_sdw_acpi stp snd_hda_codec crct10dif_pclmul llc 
polyval_clmulni snd_hda_core polyval_generic snd_hwdep 
ghash_clmulni_intel sha256_ssse3 mt7925e sha1_ssse3 snd_pcm aesni_intel 
mt7925_common snd_seq_midi crypto_simd binfmt_misc snd_seq_midi_event 
mt792x_lib cryptd processor_thermal_device_pci mt76_connac_lib 
processor_thermal_device snd_rawmidi
Oops#1 Part1
[  222.136317]  ip6table_nat mt76 cmdlinepart i915 ip6_tables 
processor_thermal_wt_hint spi_nor snd_seq mac80211 xt_conntrack rapl 
drm_buddy processor_thermal_rfim mtd snd_seq_device cfg80211(O) 
intel_rapl_msr mei_pxp mei_hdcp snd_timer processor_thermal_rapl 
nls_iso8859_1 spi_intel_pci ttm i2c_i801 nft_chain_nat snd intel_cstate 
intel_rapl_common xt_MASQUERADE libarc4 i2c_mux spi_intel 
drm_display_helper aic_load_fw(O) soundcore processor_thermal_wt_req 
mei_me i2c_smbus processor_thermal_power_floor mei cec nf_nat 
processor_thermal_mbox rc_core int340x_thermal_zone i2c_algo_bit 
igen6_edac nf_conntrack intel_pmc_core nf_defrag_ipv6 intel_vsec 
pmt_telemetry nf_defrag_ipv4 intel_hid acpi_pad nft_compat pmt_class 
sparse_keymap acpi_tad nf_tables libcrc32c joydev input_leds mac_hid 
serio_raw sch_fq_codel msr parport_pc ppdev lp parport efi_pstore 
nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic rndis_host 
usbhid uas cdc_ether hid usbnet usb_storage mii sdhci_pci cqhci r8169 
ahci intel_ish_ipc xhci_pci crc32_pclmul
[  222.140788]  sdhci realtek libahci intel_ishtp xhci_pci_renesas video 
wmi pinctrl_alderlake
[  222.146678] CR2: ffffffffffffff98
[  222.147703] ---[ end trace 0000000000000000 ]---


time to time only mt7925e restart itself with:
Message 00020003 (seq 9) timeout




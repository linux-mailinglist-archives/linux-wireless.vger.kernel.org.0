Return-Path: <linux-wireless+bounces-8080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2458CFC5B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96566B218AA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F453361;
	Mon, 27 May 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b5oZZKtM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80C6A33A;
	Mon, 27 May 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800455; cv=none; b=S1aaMpEi40tianWOdt3Iz7BZN56YFqAIYi4D3lwkzUZnRmVu8hzp7oklb1mE66WNqkPHd145XXeNhmZhhQkbYacUkceKFWRMc7aQamJDr8AzA/RLjQNb8o/1DzqvQ9UsSwYHoL/qiaTDg/RucRfbs9GInJLnMuLCwveIeEJeo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800455; c=relaxed/simple;
	bh=LY/SMQjt4ef0MedNWQo+mZzxqQhJeBIxgr3yyyFYZkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVQHXy/8DqJDRR0XrEz48poI+Eajdcyi5RB8IW6qqs+lnMT8dSODwowfpHP8ksn8S+gDruZfjEiUQOgd1ah2Yje4GbpgTjTB48MdO5OlyAooW2efnwbcuFxW1LDwjT2yZmqc3gBBpSgVMe1/tYgge9LMakS/3ISgImlwjHZBml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b5oZZKtM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R0mEc5021184;
	Mon, 27 May 2024 09:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FW54q9XMg0asIAxgeyWG9GNJSEOosc1JNTifQZcFteQ=; b=b5oZZKtMMTV+hWBx
	uxkfl+Om9TZQultzaJ1WG/d1xVG1EQlPF3koXaw+vSgUuM4vgnq6gsbatDtSKBjI
	9kQASTAiWyxUUIEK+s+1GToPscQwPcuxcw0LjJ0VrVnWa/GlmYrCsF3hBchWsSR8
	w3yb0EamMpfMfKHq1Why5hNAGFNYoxqYwG1ZBLawYJ8CMlSDshu1ZgUVPQsQ+PIx
	pDPS4qjR408ZoTpNE6biBaD2+mwBXA1v5c1rUIL6usUQsX/xDO+qUzOeecDhx9jE
	sL1NEnBwJoL9RpXFBtJC5u8hGZcWTP29dsY1vVIOf6OnmAY+n2SDhwOuVU4HjRTO
	fm7j7g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k32km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:00:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44R90Wwk001968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:00:32 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 02:00:30 -0700
Message-ID: <e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com>
Date: Mon, 27 May 2024 17:00:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci 0000:3a:00.0: Could not init core: -110
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3BhtXsnrZv6E9pABqB5ibB1KrROOpqeA
X-Proofpoint-GUID: 3BhtXsnrZv6E9pABqB5ibB1KrROOpqeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270073



On 5/27/2024 4:42 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake notebook Dell XPS 13 with
> 
>     3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
> 
> with at least a self-built Linux 6.9-rc5, on April 26th, 2024, and Linux 6.8.11, today, May 27th, 2024, the error below happened, and the device couldn’t authenticate to a WiFi network until reloading the module *ath10k_core* and *ath10k_pci* (didn’t check just *ath10k_pci*):
> 
>     $ sudo modprobe -r ath10k_pci
>     $ sudo modprobe -r ath10k_core
>     $ sudo modprobe ath10k_pci
> 
> ```
> [   49.441618] ath10k_pci 0000:3a:00.0: wmi service ready event not received
> [   49.523814] ath10k_pci 0000:3a:00.0: Could not init core: -110
> [   49.523826] ------------[ cut here ]------------
> [   49.523828] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
> [   49.523896] WARNING: CPU: 2 PID: 2990 at net/mac80211/util.c:2593 ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.524121] Modules linked in: ctr ccm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel xfrm_interface xfrm6_tunnel tunnel6 tunnel4 udp_tunnel pppox xfrm_user xfrm_algo ppp_generic slhc snd_sof_pci_intel_skl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_hda_codec_hdmi snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_ctl_led snd_sof_utils soundwire_bus snd_hda_codec_realtek snd_hda_codec_generic snd_soc_avs snd_soc_hda_codec snd_soc_skl intel_uncore_frequency intel_uncore_frequency_common binfmt_misc snd_soc_hdac_hda snd_hda_ext_core snd_soc_sst_ipc snd_soc_sst_dsp x86_pkg_temp_thermal ath10k_pci snd_soc_acpi_intel_match intel_powerclamp snd_soc_acpi coretemp ath10k_core snd_soc_core kvm_intel snd_compress snd_pcm_dmaengine nls_ascii snd_hda_intel nls_cp437 vfat ath snd_intel_dspcfg kvm fat btusb snd_intel_sdw_acpi mac80211 btrtl btintel
> snd_hda_codec mei_hdcp i915 mei_pxp mei_wdt dell_laptop
> [   49.524258]  snd_hda_core btbcm ledtrig_audio uvcvideo btmtk libarc4 snd_hwdep videobuf2_vmalloc dell_wmi intel_rapl_msr dell_smm_hwmon irqbypass bluetooth uvc snd_pcm rapl videobuf2_memops cfg80211 intel_cstate videobuf2_v4l2 dell_smbios intel_uncore dcdbas snd_timer videodev pcspkr iTCO_wdt mei_me wmi_bmof dell_wmi_descriptor joydev intel_pmc_bxt ecdh_generic intel_wmi_thunderbolt snd videobuf2_common mei iTCO_vendor_support rfkill watchdog soundcore mc ecc intel_pch_thermal drm_buddy drm_display_helper ucsi_acpi typec_ucsi cec soc_button_array intel_vbtn rc_core processor_thermal_device_pci_legacy processor_thermal_device intel_pmc_core processor_thermal_wt_hint processor_thermal_rfim ttm intel_vsec processor_thermal_rapl typec pmt_telemetry intel_rapl_common int3403_thermal pmt_class drm_kms_helper processor_thermal_wt_req int3400_thermal processor_thermal_power_floor acpi_thermal_rel processor_thermal_mbox int340x_thermal_zone intel_xhci_usb_role_switch intel_hid
> intel_soc_dts_iosf i2c_algo_bit sparse_keymap
> [   49.524400]  roles ac acpi_pad button hid_multitouch evdev serio_raw msr parport_pc ppdev lp parport loop efi_pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic usbhid dm_crypt dm_mod nvme nvme_core t10_pi crc64_rocksoft_generic crc32_pclmul crc32c_intel ghash_clmulni_intel crc64_rocksoft sha512_ssse3 hid_generic xhci_pci crc_t10dif xhci_hcd crct10dif_generic i2c_hid_acpi i2c_hid crct10dif_pclmul sha512_generic drm usbcore crc64 intel_lpss_pci i2c_i801 sha256_ssse3 sha1_ssse3 i2c_smbus hid crct10dif_common intel_lpss usb_common idma64 battery video wmi aesni_intel crypto_simd cryptd
> [   49.524520] CPU: 2 PID: 2990 Comm: kworker/u8:39 Not tainted 6.8.11-amd64 #1  Debian 6.8.11-1
> [   49.524529] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [   49.524534] Workqueue: events_unbound async_run_entry_fn
> [   49.524550] RIP: 0010:ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.524746] Code: 02 00 00 41 c6 86 85 05 00 00 00 4c 89 f7 e8 18 8b fb ff 41 89 c4 85 c0 0f 84 0d 03 00 00 48 c7 c7 30 fd 8c c1 e8 01 64 8b cc <0f> 0b eb 2d 84 c0 0f 85 9d 01 00 00 c6 87 85 05 00 00 00 e8 e9 8a
> [   49.524752] RSP: 0000:ffffa888c4977cd8 EFLAGS: 00010282
> [   49.524759] RAX: 0000000000000000 RBX: ffff88d283230538 RCX: 0000000000000027
> [   49.524764] RDX: ffff88d5ef121708 RSI: 0000000000000001 RDI: ffff88d5ef121700
> [   49.524769] RBP: ffff88d2832303c0 R08: 0000000000000000 R09: ffffa888c4977aa8
> [   49.524773] R10: ffffa888c4977aa0 R11: 0000000000000003 R12: 00000000ffffff92
> [   49.524777] R13: 0000000000000000 R14: ffff88d283230900 R15: ffff88d287224f88
> [   49.524782] FS:  0000000000000000(0000) GS:ffff88d5ef100000(0000) knlGS:0000000000000000
> [   49.524788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.524792] CR2: 0000000000000000 CR3: 000000002ae20001 CR4: 00000000003706f0
> [   49.524797] Call Trace:
> [   49.524804]  <TASK>
> [   49.524808]  ? ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.524996]  ? __warn+0x81/0x130
> [   49.525012]  ? ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.525201]  ? report_bug+0x171/0x1a0
> [   49.525211]  ? handle_bug+0x3c/0x80
> [   49.525223]  ? exc_invalid_op+0x17/0x70
> [   49.525234]  ? asm_exc_invalid_op+0x1a/0x20
> [   49.525252]  ? ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.525438]  ? ieee80211_reconfig+0x9f/0x14f0 [mac80211]
> [   49.525644]  ? schedule+0x32/0xd0
> [   49.525653]  ? wq_worker_running+0xe/0x60
> [   49.525665]  ? schedule_timeout+0x151/0x160
> [   49.525675]  ? wait_for_completion+0x95/0x160
> [   49.525687]  wiphy_resume+0x82/0x1b0 [cfg80211]
> [   49.525852]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
> [   49.525994]  dpm_run_callback+0x89/0x1e0
> [   49.526005]  device_resume+0x9c/0x240
> [   49.526012]  async_resume+0x1d/0x30
> [   49.526018]  async_run_entry_fn+0x31/0x130
> [   49.526031]  process_one_work+0x171/0x340
> [   49.526042]  worker_thread+0x27b/0x3a0
> [   49.526054]  ? __pfx_worker_thread+0x10/0x10
> [   49.526063]  kthread+0xe5/0x120
> [   49.526072]  ? __pfx_kthread+0x10/0x10
> [   49.526079]  ret_from_fork+0x31/0x50
> [   49.526091]  ? __pfx_kthread+0x10/0x10
> [   49.526098]  ret_from_fork_asm+0x1b/0x30
> [   49.526113]  </TASK>
> [   49.526116] ---[ end trace 0000000000000000 ]---
> [   49.526253] ------------[ cut here ]------------
> [   49.526256] WARNING: CPU: 2 PID: 2990 at net/mac80211/driver-ops.c:41 drv_stop+0xf5/0x100 [mac80211]
> [   49.526397] Modules linked in: ctr ccm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel xfrm_interface xfrm6_tunnel tunnel6 tunnel4 udp_tunnel pppox xfrm_user xfrm_algo ppp_generic slhc snd_sof_pci_intel_skl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_hda_codec_hdmi snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_ctl_led snd_sof_utils soundwire_bus snd_hda_codec_realtek snd_hda_codec_generic snd_soc_avs snd_soc_hda_codec snd_soc_skl intel_uncore_frequency intel_uncore_frequency_common binfmt_misc snd_soc_hdac_hda snd_hda_ext_core snd_soc_sst_ipc snd_soc_sst_dsp x86_pkg_temp_thermal ath10k_pci snd_soc_acpi_intel_match intel_powerclamp snd_soc_acpi coretemp ath10k_core snd_soc_core kvm_intel snd_compress snd_pcm_dmaengine nls_ascii snd_hda_intel nls_cp437 vfat ath snd_intel_dspcfg kvm fat btusb snd_intel_sdw_acpi mac80211 btrtl btintel
> snd_hda_codec mei_hdcp i915 mei_pxp mei_wdt dell_laptop
> [   49.526520]  snd_hda_core btbcm ledtrig_audio uvcvideo btmtk libarc4 snd_hwdep videobuf2_vmalloc dell_wmi intel_rapl_msr dell_smm_hwmon irqbypass bluetooth uvc snd_pcm rapl videobuf2_memops cfg80211 intel_cstate videobuf2_v4l2 dell_smbios intel_uncore dcdbas snd_timer videodev pcspkr iTCO_wdt mei_me wmi_bmof dell_wmi_descriptor joydev intel_pmc_bxt ecdh_generic intel_wmi_thunderbolt snd videobuf2_common mei iTCO_vendor_support rfkill watchdog soundcore mc ecc intel_pch_thermal drm_buddy drm_display_helper ucsi_acpi typec_ucsi cec soc_button_array intel_vbtn rc_core processor_thermal_device_pci_legacy processor_thermal_device intel_pmc_core processor_thermal_wt_hint processor_thermal_rfim ttm intel_vsec processor_thermal_rapl typec pmt_telemetry intel_rapl_common int3403_thermal pmt_class drm_kms_helper processor_thermal_wt_req int3400_thermal processor_thermal_power_floor acpi_thermal_rel processor_thermal_mbox int340x_thermal_zone intel_xhci_usb_role_switch intel_hid
> intel_soc_dts_iosf i2c_algo_bit sparse_keymap
> [   49.526642]  roles ac acpi_pad button hid_multitouch evdev serio_raw msr parport_pc ppdev lp parport loop efi_pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic usbhid dm_crypt dm_mod nvme nvme_core t10_pi crc64_rocksoft_generic crc32_pclmul crc32c_intel ghash_clmulni_intel crc64_rocksoft sha512_ssse3 hid_generic xhci_pci crc_t10dif xhci_hcd crct10dif_generic i2c_hid_acpi i2c_hid crct10dif_pclmul sha512_generic drm usbcore crc64 intel_lpss_pci i2c_i801 sha256_ssse3 sha1_ssse3 i2c_smbus hid crct10dif_common intel_lpss usb_common idma64 battery video wmi aesni_intel crypto_simd cryptd
> [   49.526745] CPU: 2 PID: 2990 Comm: kworker/u8:39 Tainted: G        W         6.8.11-amd64 #1  Debian 6.8.11-1
> [   49.526753] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [   49.526757] Workqueue: events_unbound async_run_entry_fn
> [   49.526768] RIP: 0010:drv_stop+0xf5/0x100 [mac80211]
> [   49.526901] Code: 0b 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 f2 03 05 00 65 ff 0d 93 3a 87 3e 0f 85 39 ff ff ff 0f 1f 44 00 00 e9 2f ff ff ff <0f> 0b 5b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
> [   49.526907] RSP: 0000:ffffa888c4977c28 EFLAGS: 00010246
> [   49.526913] RAX: 0000000000000000 RBX: ffff88d283230900 RCX: ffff88d2857bc668
> [   49.526918] RDX: 0000000080000000 RSI: 0000000000000282 RDI: ffff88d283230900
> [   49.526922] RBP: ffff88d283230900 R08: 0000000000000000 R09: 0000000000000000
> [   49.526926] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88d2832311d0
> [   49.526930] R13: ffff88d283230e10 R14: 0000000000000000 R15: ffff88d28b07dc08
> [   49.526934] FS:  0000000000000000(0000) GS:ffff88d5ef100000(0000) knlGS:0000000000000000
> [   49.526939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.526943] CR2: 0000000000000000 CR3: 000000002ae20001 CR4: 00000000003706f0
> [   49.526948] Call Trace:
> [   49.526952]  <TASK>
> [   49.526955]  ? drv_stop+0xf5/0x100 [mac80211]
> [   49.527086]  ? __warn+0x81/0x130
> [   49.527097]  ? drv_stop+0xf5/0x100 [mac80211]
> [   49.527230]  ? report_bug+0x171/0x1a0
> [   49.527241]  ? handle_bug+0x3c/0x80
> [   49.527251]  ? exc_invalid_op+0x17/0x70
> [   49.527261]  ? asm_exc_invalid_op+0x1a/0x20
> [   49.527277]  ? drv_stop+0xf5/0x100 [mac80211]
> [   49.527409]  ? drv_stop+0x12/0x100 [mac80211]
> [   49.527539]  ieee80211_do_stop+0x56a/0x800 [mac80211]
> [   49.527724]  ieee80211_stop+0x58/0x180 [mac80211]
> [   49.527923]  __dev_close_many+0xa7/0x120
> [   49.527941]  dev_close_many+0xa9/0x180
> [   49.527958]  dev_close+0x8c/0xc0
> [   49.527971]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
> [   49.528169]  wiphy_resume+0xc1/0x1b0 [cfg80211]
> [   49.528366]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
> [   49.528560]  dpm_run_callback+0x89/0x1e0
> [   49.528570]  device_resume+0x9c/0x240
> [   49.528579]  async_resume+0x1d/0x30
> [   49.528586]  async_run_entry_fn+0x31/0x130
> [   49.528600]  process_one_work+0x171/0x340
> [   49.528613]  worker_thread+0x27b/0x3a0
> [   49.528627]  ? __pfx_worker_thread+0x10/0x10
> [   49.528637]  kthread+0xe5/0x120
> [   49.528644]  ? __pfx_kthread+0x10/0x10
> [   49.528654]  ret_from_fork+0x31/0x50
> [   49.528666]  ? __pfx_kthread+0x10/0x10
> [   49.528675]  ret_from_fork_asm+0x1b/0x30
> [   49.528690]  </TASK>
> [   49.528692] ---[ end trace 0000000000000000 ]---
> ```
> 
> Please find the logs of both boots attached.
> 
> 
> Kind regards,
> 
> Paul
Are you using a distro kernel? Could you check if below patch merged in your kernel? if not can you merge it and try again?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath10k?id=e57b7d62a1b2f496caf0beba81cec3c90fad80d5


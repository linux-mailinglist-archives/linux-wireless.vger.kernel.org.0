Return-Path: <linux-wireless+bounces-6491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4D8A92BE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45881C20BD5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 06:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B66041A88;
	Thu, 18 Apr 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNDnu3Ek"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2078EDF
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420383; cv=none; b=CQP+gP/Fi8qqZpNgM8Oq1J5OemmbwjetCeRfE6u24oMCwLwiSSFKlEKbXidVcgQ5QsIEfOQg7tMMZNM9ojTeGaHYPhmDJmS4GdjhqJ0C83Pn5YfAivlTmuZ17t7/a/c/Vk2OYo8LkFTlcn/iS6wF7XtTSbJUzBzcbAFai4SQnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420383; c=relaxed/simple;
	bh=EL816leixLm7aQlccHiDm6fKRm285WqXPWCqKs/x8VU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=fjLL2yWFXIsDf3Bz0eIuQw8+TGKmECYOT91vpNh9oVu4/g0Th23TNNFJ3fAwh3GzYunv1/GBbxPXzj1V850a8flmZbx3p7Gz1+qDcPeQj1NpDl3R+83QCKJqeb57vjxiv/WyzeCYKoEDGbtg1OzFkIEGtSZtibwCHUpnGOu28UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNDnu3Ek; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I1YM8g016155;
	Thu, 18 Apr 2024 06:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GK+U52lI8JpOHTFvCowd07fBRKPuc+dBk82w2xGfYQs=; b=GN
	Dnu3EkYzKSd7l91pqS56cX0xP+v4bWIDo2RfXSF26X0w6lvBuJOiaoFWdb3G2nVi
	FUyTc2W3OWN4XNE+Qrk/NiZ89wVc1kKqAU1Ks6+wgPqgVa2OQVPntGaQjtYMT9zE
	cOGqw8mSH5x68HTvLYCVxJSjweSb2o2f4CJIfnIr7O7Om44Llvjau08hNc+sqGpr
	2401PuO1K6ePa4PxMUkA43oWL7aOl4EoWzgt4yFPNsk+vRqAeNBlqXSGDygMSQTm
	OI1TPvmoV1UoZZrLSGO9QDSQkiv59BfJYQIVL3hOGc66mGTiTnLE3ZhXkRr/K1sI
	m9KxfQSNzmP9xpXWQMAw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjf8a2hqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 06:06:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I6630k021884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 06:06:03 GMT
Received: from [10.110.20.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 23:06:03 -0700
Message-ID: <bbe13506-d8cb-4e3d-9d10-617b77bf042b@quicinc.com>
Date: Wed, 17 Apr 2024 23:06:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
 <87r0f4vzkc.fsf@kernel.org>
 <b428c741-adbe-41c2-b353-a74b574d12d4@quicinc.com>
In-Reply-To: <b428c741-adbe-41c2-b353-a74b574d12d4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SnxJqBbchseFQdD0gEfM0uNECWzREN2f
X-Proofpoint-GUID: SnxJqBbchseFQdD0gEfM0uNECWzREN2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_04,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180040

On 4/17/2024 4:32 PM, Jeff Johnson wrote:
> On 4/17/2024 7:22 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>> My Qualcomm Innovation Center copyright checker reports:
>>> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024
>>
>> I fixed this in the pending branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?=
h=3Dpending&id=3D6b928df55a671d2c9a15edc746f6b42ef544928e
>>
>> Jeff, what do you think of the patchset? Is it ready to take?
>=20
> My laptop didn't boot with this patchset in place, let me debug.

I was originally trying to test with the entire 'pending' branch, but my
laptop crashes during initial boot.

So I just tested with master+the hibernation patchset, and upon resume I'=
m
getting a bunch of the following:

Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Requested to power O=
N
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Power on setup succe=
ss
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Wait for device to e=
nter SBL or Mission mode
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: mhi n=
otify status reason MHI_CB_EE_MISSION_MODE
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi w=
ifi fw qmi service connected
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: no va=
lid response from PHY capability, choose default num_phy 2
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi f=
irmware request memory request
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi m=
em seg type 1 size 7077888
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi m=
em seg type 4 size 8454144
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi d=
ma allocation failed (7077888 B type 1), will try later with small size
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: BUG: Bad page state in process=
 kworker/u16:54  pfn:36e80
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page: refcount:1 mapcount:0 ma=
pping:0000000000000000 index:0x0 pfn:0x36e80
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: flags: 0xfffffe0000000(node=3D=
0|zone=3D1|lastcpupid=3D0x3fffff)
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page_type: 0xffffffff()
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 000fffffe0000000 00000000=
00000000 dead000000000122 0000000000000000
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 0000000000000000 00000000=
00000000 00000001ffffffff 0000000000000000
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page dumped because: nonzero _=
refcount
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Modules linked in: ccm michael=
_mic bnep amdgpu snd_hda_codec_hdmi amdxcp drm_exec gpu_sched binfmt_misc=
 qrtr_mhi nls_iso8859_1 i915 qrtr ath12k qmi_helpers mac80211 snd_ctl_led=
 ledtrig_audio radeon snd_hda_codec_realtek snd_hda_codec_generic snd_hda=
_scodec_component intel_rapl_msr intel_rapl_common snd_hda_intel snd_inte=
l_dspcfg x86_pkg_temp_thermal snd_intel_sdw_acpi intel_powerclamp snd_hda=
_codec mei_hdcp uvcvideo snd_hda_core cfg80211 snd_hwdep snd_pcm drm_suba=
lloc_helper coretemp drm_ttm_helper drm_buddy videobuf2_vmalloc btusb crc=
t10dif_pclmul uvc ttm ghash_clmulni_intel btrtl sha512_ssse3 videobuf2_me=
mops btintel sha256_ssse3 snd_seq_midi btbcm sha1_ssse3 snd_seq_midi_even=
t drm_display_helper aesni_intel videobuf2_v4l2 snd_rawmidi videodev btmt=
k cec snd_seq bluetooth crypto_simd cryptd rc_core videobuf2_common snd_s=
eq_device rapl drm_kms_helper libarc4 mc snd_timer intel_cstate mhi snd i=
2c_algo_bit ecdh_generic mei_me ecc joydev input_leds soundcore mei serio=
_raw at24 wmi_bmof mac_hid wireless_hotkey
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  tpm_infineon sch_fq_codel msr=
 parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 cd=
c_ether usbnet mii rtsx_pci_sdmmc crc32_pclmul video e1000e i2c_i801 psmo=
use rtsx_pci ahci i2c_smbus libahci xhci_pci lpc_ich xhci_pci_renesas wmi=

Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: CPU: 2 PID: 55152 Comm: kworke=
r/u16:54 Not tainted 6.9.0-rc3-wt-ath+ #28
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard=
 HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Workqueue: qmi_msg_handler qmi=
_data_ready_work [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Call Trace:
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  <TASK>
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x70/0x90
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack+0x14/0x20
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  bad_page+0x71/0x100
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  free_page_is_bad_report+0x86/=
0x90
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages_ok+0x3b3/0x410
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages+0xe7/0x110
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_direct_free+0xb9/0x180
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_free_attrs+0x3f/0x60
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_free_target_mem_ch=
unk+0x75/0x140 [ath12k]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_msg_mem_request_cb=
+0x1fb/0x370 [ath12k]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_invoke_handler+0xa3/0xd0 =
[qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_handle_message+0x6f/0x190=
 [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_data_ready_work+0x288/0x4=
60 [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? raw_spin_rq_unlock+0x14/0x4=
0
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x1a0/0x3f0
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x351/0x500
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x=
10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  kthread+0xf8/0x130
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x40/0x60
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  </TASK>
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Disabling lock debugging due t=
o kernel taint
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: BUG: Bad page state in process=
 kworker/u16:54  pfn:36f00
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page: refcount:1 mapcount:0 ma=
pping:0000000000000000 index:0x0 pfn:0x36f00
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: flags: 0xfffffe0000000(node=3D=
0|zone=3D1|lastcpupid=3D0x3fffff)
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page_type: 0xffffffff()
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 000fffffe0000000 00000000=
00000000 dead000000000122 0000000000000000
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 0000000000000000 00000000=
00000000 00000001ffffffff 0000000000000000
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page dumped because: nonzero _=
refcount
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Modules linked in: ccm michael=
_mic bnep amdgpu snd_hda_codec_hdmi amdxcp drm_exec gpu_sched binfmt_misc=
 qrtr_mhi nls_iso8859_1 i915 qrtr ath12k qmi_helpers mac80211 snd_ctl_led=
 ledtrig_audio radeon snd_hda_codec_realtek snd_hda_codec_generic snd_hda=
_scodec_component intel_rapl_msr intel_rapl_common snd_hda_intel snd_inte=
l_dspcfg x86_pkg_temp_thermal snd_intel_sdw_acpi intel_powerclamp snd_hda=
_codec mei_hdcp uvcvideo snd_hda_core cfg80211 snd_hwdep snd_pcm drm_suba=
lloc_helper coretemp drm_ttm_helper drm_buddy videobuf2_vmalloc btusb crc=
t10dif_pclmul uvc ttm ghash_clmulni_intel btrtl sha512_ssse3 videobuf2_me=
mops btintel sha256_ssse3 snd_seq_midi btbcm sha1_ssse3 snd_seq_midi_even=
t drm_display_helper aesni_intel videobuf2_v4l2 snd_rawmidi videodev btmt=
k cec snd_seq bluetooth crypto_simd cryptd rc_core videobuf2_common snd_s=
eq_device rapl drm_kms_helper libarc4 mc snd_timer intel_cstate mhi snd i=
2c_algo_bit ecdh_generic mei_me ecc joydev input_leds soundcore mei serio=
_raw at24 wmi_bmof mac_hid wireless_hotkey
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  tpm_infineon sch_fq_codel msr=
 parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 cd=
c_ether usbnet mii rtsx_pci_sdmmc crc32_pclmul video e1000e i2c_i801 psmo=
use rtsx_pci ahci i2c_smbus libahci xhci_pci lpc_ich xhci_pci_renesas wmi=

Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: CPU: 2 PID: 55152 Comm: kworke=
r/u16:54 Tainted: G    B              6.9.0-rc3-wt-ath+ #28
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard=
 HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Workqueue: qmi_msg_handler qmi=
_data_ready_work [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Call Trace:
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  <TASK>
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x70/0x90
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack+0x14/0x20
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  bad_page+0x71/0x100
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  free_page_is_bad_report+0x86/=
0x90
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages_ok+0x3b3/0x410
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages+0xe7/0x110
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_direct_free+0xb9/0x180
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_free_attrs+0x3f/0x60
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_free_target_mem_ch=
unk+0x75/0x140 [ath12k]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_msg_mem_request_cb=
+0x1fb/0x370 [ath12k]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_invoke_handler+0xa3/0xd0 =
[qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_handle_message+0x6f/0x190=
 [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_data_ready_work+0x288/0x4=
60 [qmi_helpers]
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? raw_spin_rq_unlock+0x14/0x4=
0
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x1a0/0x3f0
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x351/0x500
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x=
10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  kthread+0xf8/0x130
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x40/0x60
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  </TASK>




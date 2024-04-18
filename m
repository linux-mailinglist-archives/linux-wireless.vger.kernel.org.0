Return-Path: <linux-wireless+bounces-6519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6A8A97A7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6162830DB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600315CD44;
	Thu, 18 Apr 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A/jUpLTg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B15AD9B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437008; cv=none; b=MBOlzi7Dw0j0+E1adEXwkyNx9EuBQq02ymxI1T8osHU5hUPFbCJ4s47vdJ+QHAv4XYiB9UA9f8RBkUVtKs4meG1yoNXEZv4e2+glx+2RrCvskA7AK/I4ANkCZGhff9KPe3rSOPwnRnSFIZ4JrND66GJd+QAnqi0U4F/dDF19BDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437008; c=relaxed/simple;
	bh=yOxd9jaTIuipLJlawJXzbtqtnJYKOzC78LLPmPgDJz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZU/PyDVgMG31TGg15RlRuoT9S9j87rOResibm6U0Gw3STA9FSobg+NT+ahXdChWj4mj+7oltV1gxE9gkzHY/ZVjJvZ4RaUKFsKbeUZzCb9DxrqcNS1MmbDw95Sb6CoflFKgikXRGLc42uvpZ20BaimdtYIAJSNlb5hFSF2QOWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A/jUpLTg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I4J4bm025706;
	Thu, 18 Apr 2024 10:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=re8g6eksaN5KrvXzinPxQ8HXeSH+98qJt2yAot5kHBQ=; b=A/
	jUpLTgnOyWndHHw8XiTsD5/c5uROklCxbY42Z+xLf57HKPeAuTWmk/lcQfIab220
	1OI4gFmLNxJ2OmByquLik93huwkxu2tduJBilf4YQjhgtNJw2A93E/4gloxcwsjy
	vbJLTyKevZ6ZhdfVvDuP6MowDjiGD0dHkNqBXLXEtJIB6tT1enF0c3+JLyY6ujV0
	UY2SNEOFJxybGRZOUh8xmINY9dswXT5fiSPC5MXLLZqmt8AJD6WOxq97E49+nRYS
	JCx44yMBlt1ddkSjlxpVa+CVyM5Ia8frQHQV9A9Cix/9qsqUKSPh0dswWrp4otRs
	QuEhc26XTHq6y4TyWJug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xju9m0vvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:43:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IAhIVa002827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:43:18 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 03:43:17 -0700
Message-ID: <3f5c8df8-a513-4e04-9aac-57ca44295891@quicinc.com>
Date: Thu, 18 Apr 2024 18:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
 <87r0f4vzkc.fsf@kernel.org>
 <b428c741-adbe-41c2-b353-a74b574d12d4@quicinc.com>
 <bbe13506-d8cb-4e3d-9d10-617b77bf042b@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <bbe13506-d8cb-4e3d-9d10-617b77bf042b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UVXMelX-PDreG4ELETXwj-O7f74pvJKX
X-Proofpoint-ORIG-GUID: UVXMelX-PDreG4ELETXwj-O7f74pvJKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_08,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180076


On 4/18/2024 2:06 PM, Jeff Johnson wrote:
> On 4/17/2024 4:32 PM, Jeff Johnson wrote:
>> On 4/17/2024 7:22 AM, Kalle Valo wrote:
>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>> My Qualcomm Innovation Center copyright checker reports:
>>>> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024
>>> I fixed this in the pending branch:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/=
?h=3Dpending&id=3D6b928df55a671d2c9a15edc746f6b42ef544928e
>>>
>>> Jeff, what do you think of the patchset? Is it ready to take?
>> My laptop didn't boot with this patchset in place, let me debug.
> I was originally trying to test with the entire 'pending' branch, but m=
y
> laptop crashes during initial boot.
>
> So I just tested with master+the hibernation patchset, and upon resume =
I'm
> getting a bunch of the following:
>
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Requested to power=
 ON
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Power on setup suc=
cess
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: mhi mhi0: Wait for device to=
 enter SBL or Mission mode
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: mhi=
 notify status reason MHI_CB_EE_MISSION_MODE
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi=
 wifi fw qmi service connected
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: no =
valid response from PHY capability, choose default num_phy 2
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi=
 firmware request memory request
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi=
 mem seg type 1 size 7077888
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi=
 mem seg type 4 size 8454144
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: qmi=
 dma allocation failed (7077888 B type 1), will try later with small size=

> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: BUG: Bad page state in proce=
ss kworker/u16:54  pfn:36e80
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page: refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x36e80
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: flags: 0xfffffe0000000(node=3D=
0|zone=3D1|lastcpupid=3D0x3fffff)
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page_type: 0xffffffff()
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 000fffffe0000000 000000=
0000000000 dead000000000122 0000000000000000
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 0000000000000000 000000=
0000000000 00000001ffffffff 0000000000000000
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page dumped because: nonzero=
 _refcount
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Modules linked in: ccm micha=
el_mic bnep amdgpu snd_hda_codec_hdmi amdxcp drm_exec gpu_sched binfmt_mi=
sc qrtr_mhi nls_iso8859_1 i915 qrtr ath12k qmi_helpers mac80211 snd_ctl_l=
ed ledtrig_audio radeon snd_hda_codec_realtek snd_hda_codec_generic snd_h=
da_scodec_component intel_rapl_msr intel_rapl_common snd_hda_intel snd_in=
tel_dspcfg x86_pkg_temp_thermal snd_intel_sdw_acpi intel_powerclamp snd_h=
da_codec mei_hdcp uvcvideo snd_hda_core cfg80211 snd_hwdep snd_pcm drm_su=
balloc_helper coretemp drm_ttm_helper drm_buddy videobuf2_vmalloc btusb c=
rct10dif_pclmul uvc ttm ghash_clmulni_intel btrtl sha512_ssse3 videobuf2_=
memops btintel sha256_ssse3 snd_seq_midi btbcm sha1_ssse3 snd_seq_midi_ev=
ent drm_display_helper aesni_intel videobuf2_v4l2 snd_rawmidi videodev bt=
mtk cec snd_seq bluetooth crypto_simd cryptd rc_core videobuf2_common snd=
_seq_device rapl drm_kms_helper libarc4 mc snd_timer intel_cstate mhi snd=
 i2c_algo_bit ecdh_generic mei_me ecc joydev input_leds soundcore mei ser=
io_raw at24 wmi_bmof mac_hid wireless_hotkey
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  tpm_infineon sch_fq_codel m=
sr parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 =
cdc_ether usbnet mii rtsx_pci_sdmmc crc32_pclmul video e1000e i2c_i801 ps=
mouse rtsx_pci ahci i2c_smbus libahci xhci_pci lpc_ich xhci_pci_renesas w=
mi
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: CPU: 2 PID: 55152 Comm: kwor=
ker/u16:54 Not tainted 6.9.0-rc3-wt-ath+ #28
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packa=
rd HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Workqueue: qmi_msg_handler q=
mi_data_ready_work [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Call Trace:
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  <TASK>
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x70/0x90
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack+0x14/0x20
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  bad_page+0x71/0x100
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  free_page_is_bad_report+0x8=
6/0x90
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages_ok+0x3b3/0x410=

> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages+0xe7/0x110
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_direct_free+0xb9/0x180
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_free_attrs+0x3f/0x60
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_free_target_mem_=
chunk+0x75/0x140 [ath12k]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_msg_mem_request_=
cb+0x1fb/0x370 [ath12k]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_invoke_handler+0xa3/0xd=
0 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_handle_message+0x6f/0x1=
90 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_data_ready_work+0x288/0=
x460 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? raw_spin_rq_unlock+0x14/0=
x40
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x1a0/0x3f=
0
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x351/0x500
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/=
0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  kthread+0xf8/0x130
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x40/0x60
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30=

> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  </TASK>
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Disabling lock debugging due=
 to kernel taint
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: BUG: Bad page state in proce=
ss kworker/u16:54  pfn:36f00
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page: refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x36f00
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: flags: 0xfffffe0000000(node=3D=
0|zone=3D1|lastcpupid=3D0x3fffff)
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page_type: 0xffffffff()
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 000fffffe0000000 000000=
0000000000 dead000000000122 0000000000000000
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: raw: 0000000000000000 000000=
0000000000 00000001ffffffff 0000000000000000
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: page dumped because: nonzero=
 _refcount
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Modules linked in: ccm micha=
el_mic bnep amdgpu snd_hda_codec_hdmi amdxcp drm_exec gpu_sched binfmt_mi=
sc qrtr_mhi nls_iso8859_1 i915 qrtr ath12k qmi_helpers mac80211 snd_ctl_l=
ed ledtrig_audio radeon snd_hda_codec_realtek snd_hda_codec_generic snd_h=
da_scodec_component intel_rapl_msr intel_rapl_common snd_hda_intel snd_in=
tel_dspcfg x86_pkg_temp_thermal snd_intel_sdw_acpi intel_powerclamp snd_h=
da_codec mei_hdcp uvcvideo snd_hda_core cfg80211 snd_hwdep snd_pcm drm_su=
balloc_helper coretemp drm_ttm_helper drm_buddy videobuf2_vmalloc btusb c=
rct10dif_pclmul uvc ttm ghash_clmulni_intel btrtl sha512_ssse3 videobuf2_=
memops btintel sha256_ssse3 snd_seq_midi btbcm sha1_ssse3 snd_seq_midi_ev=
ent drm_display_helper aesni_intel videobuf2_v4l2 snd_rawmidi videodev bt=
mtk cec snd_seq bluetooth crypto_simd cryptd rc_core videobuf2_common snd=
_seq_device rapl drm_kms_helper libarc4 mc snd_timer intel_cstate mhi snd=
 i2c_algo_bit ecdh_generic mei_me ecc joydev input_leds soundcore mei ser=
io_raw at24 wmi_bmof mac_hid wireless_hotkey
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  tpm_infineon sch_fq_codel m=
sr parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 =
cdc_ether usbnet mii rtsx_pci_sdmmc crc32_pclmul video e1000e i2c_i801 ps=
mouse rtsx_pci ahci i2c_smbus libahci xhci_pci lpc_ich xhci_pci_renesas w=
mi
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: CPU: 2 PID: 55152 Comm: kwor=
ker/u16:54 Tainted: G    B              6.9.0-rc3-wt-ath+ #28
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packa=
rd HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Workqueue: qmi_msg_handler q=
mi_data_ready_work [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel: Call Trace:
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  <TASK>
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x70/0x90
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dump_stack+0x14/0x20
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  bad_page+0x71/0x100
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  free_page_is_bad_report+0x8=
6/0x90
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages_ok+0x3b3/0x410=

> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  __free_pages+0xe7/0x110
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_direct_free+0xb9/0x180
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  dma_free_attrs+0x3f/0x60
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_free_target_mem_=
chunk+0x75/0x140 [ath12k]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ath12k_qmi_msg_mem_request_=
cb+0x1fb/0x370 [ath12k]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_invoke_handler+0xa3/0xd=
0 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_handle_message+0x6f/0x1=
90 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  qmi_data_ready_work+0x288/0=
x460 [qmi_helpers]
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? raw_spin_rq_unlock+0x14/0=
x40
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x1a0/0x3f=
0
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x351/0x500
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/=
0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  kthread+0xf8/0x130
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x40/0x60
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30=

> Apr 17 21:38:04 qca-HP-ZBook-14-G2 kernel:  </TASK>

Thanks for testing. I am able to reproduce this issue (although not exact=
ly same crash signature) after disabling DMA remap. Just submit below pat=
ch to fix this issue, please help review.

=C2=A0=C2=A0=C2=A0=C2=A0 wifi: ath12k: fix kernel crash during resume

>
>


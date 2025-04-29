Return-Path: <linux-wireless+bounces-22220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87548AA1C87
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 22:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A71446701F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B226B968;
	Tue, 29 Apr 2025 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LUBSkH+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FE26982C;
	Tue, 29 Apr 2025 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960167; cv=pass; b=IjVbGh0AJUjwuKliMgI52VsxF1TinGkghPvttlqPv/GBTO87pnrc7nh+wM3P6kln1K8bpMUrY9JLS0+oRH8GSSh6xs09bDoYx26yFtvVY6+F5YrrmDn7IRxaeIG/LSMWQa+uxucn5TKmZG/krmQZtvLSb7xTTKJTY0jvrHBseRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960167; c=relaxed/simple;
	bh=ojkbAhBUf5linPerOsWUQ0FO7YunvDO8rF/5A2SCnNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZAciREQE5aBBI1IKjlFFT5AT5GQMhmHXB5QDM6fCDsccSFC/z4SCFZ0gxO5E5WJ23pdDWtOf/zowxN+WQlAf47TKhG5iKZYUSao/iYq3TFmUk1EoPYCDtjrbf75MxevYmt9y8IiHJRu4JQtBmRl9A5kva/2Iy9qABA9udc4nes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LUBSkH+T; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745960116; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U3KeHQdnauWazawBLwav0VA0mlkF30vT3Njanh6aZHJUzZZtQb5R+kI2Iy3UUeg5AvxaYMPSZ3So/e/lrSCXf/wMRcb4vbmzHZJN57PA7s1UZIBeNznGUvSqIBWOsYgYuzLCcO5rCCG0E9ccWThc3xxWkrP10k90z1DAefQeP1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745960116; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=odzMyQM3vPCzlJNKRWyRYkcnhr/ay6CAo78WICcDwlw=; 
	b=D/SkpRXP+jgAI7q2YBuJk/W2HSYyHke2DdHyZAyj2yPiRx8bNlfCHCwl0qHqpStWr/Amy2p2yWvm1pzJbp95a3m+Z0KJAI/Fvkx9iaLG8SwQZ0WMAfY8spQlO319FZOeMT7sGLQXstHI7LoQI/ZHqsFf7ytIO06/YYLcUCgfyZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745960116;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=odzMyQM3vPCzlJNKRWyRYkcnhr/ay6CAo78WICcDwlw=;
	b=LUBSkH+Tu8hgdrM0nVWr1TqtIRmuT7M85VKMLnGNvVBD8mtyZu1ZhZXyFHNJ8msO
	lk+SNcYg2yBrGKGIp82cKMufV5YnmWmZsfGDWjebm1ett9eD35846V1621JbaIOvC7G
	BfW5bTsrzaKuEnFM2RwIx7mAU1IrY/fMfMfTM0xA=
Received: by mx.zohomail.com with SMTPS id 1745960113656306.3519637759904;
	Tue, 29 Apr 2025 13:55:13 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A7C89180D2A; Tue, 29 Apr 2025 22:55:07 +0200 (CEST)
Date: Tue, 29 Apr 2025 22:55:07 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	Youssef Samir <quic_yabdulra@quicinc.com>, Matthew Leung <quic_mattleun@quicinc.com>, 
	Yan Zhen <yanzhen@vivo.com>, Kunwu Chan <chentao@kylinos.cn>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Troy Hanson <quic_thanson@quicinc.com>, kernel@collabora.com, Carl Vanderlip <quic_carlv@quicinc.com>, 
	Sumit Garg <sumit.garg@kernel.org>, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org
Subject: Re: [PATCH v3] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
Message-ID: <vxyzortbnqc4znvy2gtuoufrcsddyhzc37ewchklszoburlw4p@xey7znoqgb54>
References: <20250429122351.108684-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hmycg4mkzmf4pwnf"
Content-Disposition: inline
In-Reply-To: <20250429122351.108684-1-usama.anjum@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/244.214.33
X-ZohoMailClient: External


--hmycg4mkzmf4pwnf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
MIME-Version: 1.0

Hi,

On Tue, Apr 29, 2025 at 05:23:35PM +0500, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation. There is a crash report where at resume time, the memory
> from the dma doesn't get allocated and MHI fails to re-initialize.
> There is fragmentation/memory pressure.
>=20
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
>=20
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.
>=20
> Here are the crash logs:
>=20
> [ 3029.338587] mhi mhi0: Requested to power ON
> [ 3029.338621] mhi mhi0: Power on setup success
> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc0=
4(GFP_NOIO|GFP_DMA32), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.=
11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf968=
6b5ff0bd7
> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2=
024
> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> [ 3029.668717] Call Trace:
> [ 3029.668722]  <TASK>
> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
> [ 3029.668738]  warn_alloc+0x164/0x190
> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> [ 3029.668790]  dma_direct_alloc+0x70/0x270
> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d=
6a2c597067e16d2fedc0]
> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d=
6a2c597067e16d2fedc0]
> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2=
c597067e16d2fedc0]
> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668853]  process_one_work+0x17e/0x330
> [ 3029.668861]  worker_thread+0x2ce/0x3f0
> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
> [ 3029.668873]  kthread+0xd2/0x100
> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
> [ 3029.668885]  ret_from_fork+0x34/0x50
> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
> [ 3029.668910]  </TASK>
>=20
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.5229=
7.6
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

This breaks ath12k on my T14s Snapdragon with WCN785x. After a
suspend/resume cycle the following is in my logs (and the resume
is super slow). Additionally at shutdown ath12k crashes with a
NULL pointer dereference in mhi_deinit_dev_ctxt, which got called
by mhi_unprepare_after_power_down, which got called by ath12k_mhi_stop.
This happens after filesystem umount and I don't have anything
configured right now to get logs from that point, so it is not
included in the log from the suspend/resume cycle down below:

=2E..
[   28.385370] ath12k_pci 0004:01:00.0: failed to set mhi state INIT(0) in =
current mhi state (0x1)
[   28.385379] ath12k_pci 0004:01:00.0: failed to set mhi state: INIT(0)
[   28.385383] ath12k_pci 0004:01:00.0: failed to start mhi: -22
[   28.385387] ath12k_pci 0004:01:00.0: failed to power up hif during resum=
e: -22
[   28.385391] ath12k_pci 0004:01:00.0: failed to early resume core: -22
[   28.385393] ath12k_pci 0004:01:00.0: PM: dpm_run_callback(): pci_pm_resu=
me_early returns -22
[   28.385413] ath12k_pci 0004:01:00.0: PM: failed to resume async early: e=
rror -22
[   28.385513] qcom_mhi_qrtr mhi0_IPCR: Current EE: DISABLE Required EE Mas=
k: 0x4
[   28.385521] qcom_mhi_qrtr mhi0_IPCR: failed to prepare for autoqueue tra=
nsfer -107
[   28.385526] qcom_mhi_qrtr mhi0_IPCR: PM: dpm_run_callback(): qcom_mhi_qr=
tr_pm_resume_early [qrtr_mhi] returns -107
[   28.385541] qcom_mhi_qrtr mhi0_IPCR: PM: failed to resume early: error -=
107
[   50.146823] ath12k_pci 0004:01:00.0: timeout while waiting for restart c=
omplete
[   50.146830] ath12k_pci 0004:01:00.0: failed to resume core: -110
[   50.146834] ath12k_pci 0004:01:00.0: PM: dpm_run_callback(): pci_pm_resu=
me returns -110
[   50.146849] ath12k_pci 0004:01:00.0: PM: failed to resume async: error -=
110
[   53.218794] ath12k_pci 0004:01:00.0: wmi command 16387 timeout
[   53.218801] ath12k_pci 0004:01:00.0: failed to send WMI_PDEV_SET_PARAM c=
md
[   53.218808] ath12k_pci 0004:01:00.0: failed to set ac override for ARP: =
-11
[   53.218813] ath12k_pci 0004:01:00.0: fail to start mac operations in pde=
v idx 0 ret -11
[   53.218817] ------------[ cut here ]------------
[   53.218820] Hardware became unavailable upon resume. This could be a sof=
tware issue prior to suspend or a hardware issue.
[   53.218855] WARNING: CPU: 2 PID: 1958 at net/mac80211/util.c:1829 ieee80=
211_reconfig+0x37c/0x1718 [mac80211]
[   53.218936] Modules linked in: reset_gpio snd_soc_wsa884x q6prm_clocks q=
6apm_dai q6apm_lpass_dais snd_q6dsp_common q6prm michael_mic rfcomm wiregua=
rd libchacha20poly1305 chacha_neon libchacha poly1305_neon ip6_udp_tunnel u=
dp_tunnel libcurve25519_generic binfmt_misc qrtr_mhi ath12k mac80211 libarc=
4 cfg80211 mhi hci_uart btqca btbcm snd_soc_x1e80100 snd_soc_qcom_sdw snd_s=
oc_qcom_common bluetooth ecdh_generic ecc qcom_spmi_temp_alarm rfkill snd_q=
6apm snd_soc_hdmi_codec fastrpc snd_soc_lpass_va_macro snd_soc_lpass_tx_mac=
ro snd_soc_lpass_rx_macro snd_soc_lpass_wsa_macro soundwire_qcom snd_soc_wc=
d938x slimbus snd_soc_lpass_macro_common snd_soc_wcd938x_sdw pci_pwrctrl_pw=
rseq regmap_sdw snd_soc_wcd_mbhc coresight_stm coresight_funnel coresight_t=
mc snd_soc_wcd_classh coresight_cti stm_core coresight_replicator soundwire=
_bus coresight mux_gpio fuse nfnetlink ip_tables x_tables ipv6 gpio_sbu_mux=
 panel_edp msm hid_multitouch drm_exec ocmem gpu_sched drm_dp_aux_bus rpmsg=
_ctrl apr rpmsg_char qrtr_smd i2c_hid_of qcom_pd_mapper
[   53.219100]  ps883x phy_nxp_ptn3222 i2c_hid drm_display_helper nvme phy_=
qcom_qmp_combo leds_qcom_lpg ucsi_glink pmic_glink_altmode nvme_core aux_hp=
d_bridge typec_ucsi qcom_battmgr sm3_ce sm3 led_class_multicolor qcom_q6v5_=
pas sha3_ce rtc_pm8xxx phy_qcom_eusb2_repeater qcom_pbs drm_client_lib aux_=
bridge sha512_ce qcom_pil_info drm_kms_helper qcom_common qcom_pon sha512_a=
rm64 qcom_glink_smem typec qcom_q6v5 nvmem_qcom_spmi_sdam dispcc_x1e80100 d=
rm pwrseq_qcom_wcn pinctrl_sm8550_lpass_lpi pwrseq_core i2c_qcom_geni qcom_=
stats pinctrl_lpass_lpi phy_qcom_edp phy_qcom_qmp_usb qcom_sysmon tcsrcc_x1=
e80100 llcc_qcom gpucc_x1e80100 phy_qcom_snps_eusb2 mdt_loader lpasscc_sc82=
80xp pcie_qcom qcom_cpucp_mbox icc_bwmon phy_qcom_qmp_pcie qrtr pmic_glink =
pdr_interface qcom_pdr_msg pwm_bl socinfo backlight qmi_helpers
[   53.219234] CPU: 2 UID: 0 PID: 1958 Comm: kworker/u49:49 Not tainted 6.1=
5.0-rc4+ #95 PREEMPT=20
[   53.219241] Hardware name: LENOVO 21N1CTO1WW/21N1CTO1WW, BIOS N42ET85W (=
2.15 ) 11/22/2024
[   53.219245] Workqueue: async async_run_entry_fn
[   53.219258] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[   53.219265] pc : ieee80211_reconfig+0x37c/0x1718 [mac80211]
[   53.219315] lr : ieee80211_reconfig+0x37c/0x1718 [mac80211]
[   53.219362] sp : ffff8000853ebb30
[   53.219364] x29: ffff8000853ebbf0 x28: 0000000000000000 x27: 00000000000=
00000
[   53.219373] x26: ffff1ce140047428 x25: 0000000000000000 x24: ffff1ce1408=
f7c05
[   53.219380] x23: ffff1ce14aaa05b8 x22: 0000000000000010 x21: 00000000fff=
ffff5
[   53.219387] x20: 0000000000000000 x19: ffff1ce14aaa0900 x18: 00000000fff=
ffffe
[   53.219394] x17: 72617774666f7320 x16: 6120656220646c75 x15: 6f632073696=
85420
[   53.219401] x14: 2e656d7573657220 x13: 0a2e657573736920 x12: 65726177647=
26168
[   53.219408] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffdacf6aa=
7749c
[   53.219415] x8 : 0000000000000507 x7 : ffffdacf6d031138 x6 : ffffdacf6d0=
31138
[   53.219422] x5 : ffff1ce8bbe76508 x4 : 0000000000000000 x3 : ffff42194ef=
d1000
[   53.219429] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1ce149c=
aa300
[   53.219437] Call trace:
[   53.219440]  ieee80211_reconfig+0x37c/0x1718 [mac80211] (P)
[   53.219490]  ieee80211_resume+0x54/0x78 [mac80211]
[   53.219541]  wiphy_resume+0x8c/0x200 [cfg80211]
[   53.219603]  dpm_run_callback+0x50/0x188
[   53.219614]  device_resume+0xc4/0x1f8
[   53.219621]  async_resume+0x2c/0x50
[   53.219628]  async_run_entry_fn+0x3c/0x160
[   53.219634]  process_one_work+0x158/0x3c8
[   53.219643]  worker_thread+0x2e0/0x418
[   53.219650]  kthread+0x14c/0x230
[   53.219657]  ret_from_fork+0x10/0x20
[   53.219666] ---[ end trace 0000000000000000 ]---
[   53.220154] ------------[ cut here ]------------
[   53.220158] WARNING: CPU: 2 PID: 1958 at net/mac80211/driver-ops.c:41 dr=
v_stop+0x1cc/0x1e8 [mac80211]
[   53.220235] Modules linked in: reset_gpio snd_soc_wsa884x q6prm_clocks q=
6apm_dai q6apm_lpass_dais snd_q6dsp_common q6prm michael_mic rfcomm wiregua=
rd libchacha20poly1305 chacha_neon libchacha poly1305_neon ip6_udp_tunnel u=
dp_tunnel libcurve25519_generic binfmt_misc qrtr_mhi ath12k mac80211 libarc=
4 cfg80211 mhi hci_uart btqca btbcm snd_soc_x1e80100 snd_soc_qcom_sdw snd_s=
oc_qcom_common bluetooth ecdh_generic ecc qcom_spmi_temp_alarm rfkill snd_q=
6apm snd_soc_hdmi_codec fastrpc snd_soc_lpass_va_macro snd_soc_lpass_tx_mac=
ro snd_soc_lpass_rx_macro snd_soc_lpass_wsa_macro soundwire_qcom snd_soc_wc=
d938x slimbus snd_soc_lpass_macro_common snd_soc_wcd938x_sdw pci_pwrctrl_pw=
rseq regmap_sdw snd_soc_wcd_mbhc coresight_stm coresight_funnel coresight_t=
mc snd_soc_wcd_classh coresight_cti stm_core coresight_replicator soundwire=
_bus coresight mux_gpio fuse nfnetlink ip_tables x_tables ipv6 gpio_sbu_mux=
 panel_edp msm hid_multitouch drm_exec ocmem gpu_sched drm_dp_aux_bus rpmsg=
_ctrl apr rpmsg_char qrtr_smd i2c_hid_of qcom_pd_mapper
[   53.220351]  ps883x phy_nxp_ptn3222 i2c_hid drm_display_helper nvme phy_=
qcom_qmp_combo leds_qcom_lpg ucsi_glink pmic_glink_altmode nvme_core aux_hp=
d_bridge typec_ucsi qcom_battmgr sm3_ce sm3 led_class_multicolor qcom_q6v5_=
pas sha3_ce rtc_pm8xxx phy_qcom_eusb2_repeater qcom_pbs drm_client_lib aux_=
bridge sha512_ce qcom_pil_info drm_kms_helper qcom_common qcom_pon sha512_a=
rm64 qcom_glink_smem typec qcom_q6v5 nvmem_qcom_spmi_sdam dispcc_x1e80100 d=
rm pwrseq_qcom_wcn pinctrl_sm8550_lpass_lpi pwrseq_core i2c_qcom_geni qcom_=
stats pinctrl_lpass_lpi phy_qcom_edp phy_qcom_qmp_usb qcom_sysmon tcsrcc_x1=
e80100 llcc_qcom gpucc_x1e80100 phy_qcom_snps_eusb2 mdt_loader lpasscc_sc82=
80xp pcie_qcom qcom_cpucp_mbox icc_bwmon phy_qcom_qmp_pcie qrtr pmic_glink =
pdr_interface qcom_pdr_msg pwm_bl socinfo backlight qmi_helpers
[   53.220444] CPU: 2 UID: 0 PID: 1958 Comm: kworker/u49:49 Tainted: G     =
   W           6.15.0-rc4+ #95 PREEMPT=20
[   53.220452] Tainted: [W]=3DWARN
[   53.220455] Hardware name: LENOVO 21N1CTO1WW/21N1CTO1WW, BIOS N42ET85W (=
2.15 ) 11/22/2024
[   53.220458] Workqueue: async async_run_entry_fn
[   53.220467] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[   53.220472] pc : drv_stop+0x1cc/0x1e8 [mac80211]
[   53.220521] lr : ieee80211_stop_device+0x8c/0xa8 [mac80211]
[   53.220580] sp : ffff8000853eb9f0
[   53.220582] x29: ffff8000853eb9f0 x28: 0000000000000000 x27: 00000000000=
00000
[   53.220591] x26: ffff1ce140047428 x25: ffff8000853eba50 x24: ffff8000853=
eba50
[   53.220598] x23: 0000000000000000 x22: 0000000000000001 x21: 00000000000=
00000
[   53.220604] x20: 0000000000000000 x19: ffff1ce14aaa0900 x18: 00000000fff=
ffffe
[   53.220611] x17: ffff42194efd1000 x16: ffff800080010000 x15: 6f632073696=
85420
[   53.220618] x14: 000000000000037f x13: 000000000000037f x12: 071c71c71c7=
1c71c
[   53.220625] x11: ffff1ce8bbe88b8c x10: 1f0348adc6bb8584 x9 : ffffdacf676=
22b3c
[   53.220633] x8 : ffff1ce149e1e550 x7 : 0000000000000000 x6 : 00000000000=
0003f
[   53.220640] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00000000000=
00003
[   53.220646] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000=
00000
[   53.220652] Call trace:
[   53.220654]  drv_stop+0x1cc/0x1e8 [mac80211] (P)
[   53.220702]  ieee80211_stop_device+0x8c/0xa8 [mac80211]
[   53.220751]  ieee80211_do_stop+0x644/0x830 [mac80211]
[   53.220798]  ieee80211_stop+0x60/0x1b0 [mac80211]
[   53.220845]  __dev_close_many+0xbc/0x1f0
[   53.220857]  dev_close_many+0x94/0x160
[   53.220863]  netif_close+0x78/0xa0
[   53.220868]  dev_close+0x3c/0x70
[   53.220876]  cfg80211_shutdown_all_interfaces+0x4c/0x118 [cfg80211]
[   53.220935]  wiphy_resume+0xc0/0x200 [cfg80211]
[   53.220985]  dpm_run_callback+0x50/0x188
[   53.220992]  device_resume+0xc4/0x1f8
[   53.220999]  async_resume+0x2c/0x50
[   53.221006]  async_run_entry_fn+0x3c/0x160
[   53.221012]  process_one_work+0x158/0x3c8
[   53.221020]  worker_thread+0x2e0/0x418
[   53.221027]  kthread+0x14c/0x230
[   53.221033]  ret_from_fork+0x10/0x20
[   53.221039] ---[ end trace 0000000000000000 ]---
[   53.221223] ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume [cfg802=
11] returns -11
[   53.221277] ieee80211 phy0: PM: failed to resume async: error -11
[   53.667179] OOM killer enabled.
[   53.667182] Restarting tasks ... done.
[   53.668270] random: crng reseeded on system resumption
[   53.668317] PM: suspend exit
[   56.804822] ath12k_pci 0004:01:00.0: wmi command 16387 timeout
[   56.804845] ath12k_pci 0004:01:00.0: failed to send WMI_PDEV_SET_PARAM c=
md
[   56.804859] ath12k_pci 0004:01:00.0: failed to enable PMF QOS: (-11
[   56.804872] ath12k_pci 0004:01:00.0: fail to start mac operations in pde=
v idx 0 ret -11
=2E..

-- Sebastian

--hmycg4mkzmf4pwnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgRPKcACgkQ2O7X88g7
+pqErQ//WBW3sm7T8qldxt3HtCxP41rwt3Z5JH+j5o501AH/2ZZ4Btwb1myeIMZU
NKdEq3BVp7NTjIoCk3QjposMCOmC3wrdvnHNLFTmUTyE8Fjk3+8wUfnna813UU6J
QVVR+EWOwH79O92w0GUrcOEiJR6FTjLNRbU2JXoYzTccFDi1JBmK1hsdPxiHiocy
hfiJzHXkBMF5ak+Ot7bf6jQFtHfBYisC4r2VecB2yUjRSBTCh0weIKY2xCTkyWCf
4UMxbpuEHNuRAxOh/HmF2zDdGmYSNWj9pDfRnWEPt0W1BpN8r90SF70wmBJ0YJDt
I10ux88WvBCH2giN7xv/T9crvKiwDKxyS3LzXfKNNsvshXp6ryE5oprc5X5RuGzd
U8GK0nLNCvOguQPFX8yGs1i9cMrw52rZmmEsbzSvr5kyJ69tsMV867Z8KOulDRhB
4R8JagvbRH8twF0Ln0v8l9MAgj/lXRJjjkyAPQWP4s0TnCksbegXXTGPrwPOuLz5
inPkDwqDqCFGImfcEV/XXfBbr3zq9PPAVBt6exlCMCqneJPy+m+FQwdvw8DczzWD
pl6QBw5EUnxZYjsNmsiqC80LcoOAzVJUnHvl4f1BiwgYYLaV3z09+cyw8WZJgqRf
DjBNYl+mlzH3tuVYJsNRRmqcV0ijqtbwK++HeEqSuer68hXetEM=
=L590
-----END PGP SIGNATURE-----

--hmycg4mkzmf4pwnf--


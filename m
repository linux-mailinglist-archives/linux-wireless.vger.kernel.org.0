Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF59674ED5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 09:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjATIBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjATIBg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 03:01:36 -0500
Received: from out28-109.mail.aliyun.com (out28-109.mail.aliyun.com [115.124.28.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498AC5FE8
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 00:01:33 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436267|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00337772-7.75324e-05-0.996545;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047206;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.Qy.4f2j_1674201686;
Received: from eq59.localnet(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.Qy.4f2j_1674201686)
          by smtp.aliyun-inc.com;
          Fri, 20 Jan 2023 16:01:27 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] wifi: iwlwifi: pcie: disable tx_with_siso_diversity for
 AX101NGW
Date:   Fri, 20 Jan 2023 16:01:25 +0800
Message-ID: <12137238.O9o76ZdvQC@eq59>
In-Reply-To: <20230119181357.1786-1-aiden.leong@aibsd.com>
References: <20230119181357.1786-1-aiden.leong@aibsd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5642384.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart5642384.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Aiden Leong <aiden.leong@aibsd.com>
To: linux-wireless@vger.kernel.org
Date: Fri, 20 Jan 2023 16:01:25 +0800
Message-ID: <12137238.O9o76ZdvQC@eq59>
In-Reply-To: <20230119181357.1786-1-aiden.leong@aibsd.com>
References: <20230119181357.1786-1-aiden.leong@aibsd.com>
MIME-Version: 1.0

On 2023=E5=B9=B41=E6=9C=8820=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94 CST =E4=B8=
=8A=E5=8D=882:13:57 Aiden Leong wrote:
> AX101NGW has only one antenna, so we should disable
> tx_with_siso_diversity for it.
>=20
> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c index
> 99768d6a6032..60f0c7e8248b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -990,7 +990,7 @@ static const struct iwl_dev_info iwl_dev_info_table[]=
 =3D
> { IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
>  		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
>  		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,=20
IWL_CFG_ANY,
> -		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
> +		      iwl_cfg_quz_a0_hr_b0, iwl_ax101_name),
>  	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
>  		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
>  		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,

I'd like to provide partial dmesg related to NMI_INTERRUPT_UMAC_FATAL:

[    3.996092] Intel(R) Wireless WiFi driver for Linux
[    3.996183] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    4.013566] iwlwifi 0000:00:14.3: api flags index 2 larger than supporte=
d by=20
driver
[    4.013591] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:=20
89.3.35.37
[    4.014324] iwlwifi 0000:00:14.3: loaded firmware version 72.daa05125.0 =
QuZ-
a0-hr-b0-72.ucode op_mode iwlmvm
[    4.877660] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=
=3D0x351
[    5.358006] iwlwifi 0000:00:14.3: Detected RF HR1 B3, rfid=3D0x10c000
[    5.398303] iwlwifi 0000:00:14.3: base HW address: xx:xx:xx:xx:xx:xx
[    5.416957] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[   11.086032] wlo1: authenticate with xx:xx:xx:xx:xx:xx
[   11.090429] wlo1: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
[   11.118635] wlo1: authenticated
[   11.120203] wlo1: associate with xx:xx:xx:xx:xx:xx (try 1/3)
[   11.121835] wlo1: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1931=20
status=3D0 aid=3D5)
[   11.122896] iwlwifi 0000:00:14.3: Microcode SW error detected. Restartin=
g=20
0x0.
[   11.122977] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   11.122979] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   11.122981] iwlwifi 0000:00:14.3: Loaded firmware version: 72.daa05125.0=
 QuZ-
a0-hr-b0-72.ucode
[   11.122983] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   11.122985] iwlwifi 0000:00:14.3: 0x0000A210 | trm_hw_status0
[   11.122987] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   11.122988] iwlwifi 0000:00:14.3: 0x004CC13E | branchlink2
[   11.122990] iwlwifi 0000:00:14.3: 0x004C25DE | interruptlink1
[   11.122991] iwlwifi 0000:00:14.3: 0x004C25DE | interruptlink2
[   11.122992] iwlwifi 0000:00:14.3: 0x0000B5C2 | data1
[   11.122994] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   11.122995] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   11.122996] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   11.122998] iwlwifi 0000:00:14.3: 0x0052D529 | tsf low
[   11.122999] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   11.123000] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   11.123001] iwlwifi 0000:00:14.3: 0x00533003 | time gp2
[   11.123003] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   11.123004] iwlwifi 0000:00:14.3: 0x00000048 | uCode version major
[   11.123005] iwlwifi 0000:00:14.3: 0xDAA05125 | uCode version minor
[   11.123006] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   11.123008] iwlwifi 0000:00:14.3: 0x18C89001 | board version
[   11.123009] iwlwifi 0000:00:14.3: 0x8003FC01 | hcmd
[   11.123010] iwlwifi 0000:00:14.3: 0x24020000 | isr0
[   11.123011] iwlwifi 0000:00:14.3: 0x60000000 | isr1
[   11.123012] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   11.123014] iwlwifi 0000:00:14.3: 0x00C1400C | isr3
[   11.123015] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   11.123016] iwlwifi 0000:00:14.3: 0x0201001C | last cmd Id
[   11.123017] iwlwifi 0000:00:14.3: 0x0000B5C2 | wait_event
[   11.123018] iwlwifi 0000:00:14.3: 0x00000094 | l2p_control
[   11.123019] iwlwifi 0000:00:14.3: 0x00010034 | l2p_duration
[   11.123021] iwlwifi 0000:00:14.3: 0x0000000F | l2p_mhvalid
[   11.123022] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   11.123023] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[   11.123024] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   11.123025] iwlwifi 0000:00:14.3: 0x0000B0F8 | flow_handler
[   11.123066] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   11.123067] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   11.123068] iwlwifi 0000:00:14.3: 0x20101A0D | ADVANCED_SYSASSERT
[   11.123070] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   11.123071] iwlwifi 0000:00:14.3: 0x80455E9C | umac branchlink2
[   11.123072] iwlwifi 0000:00:14.3: 0x010003C0 | umac interruptlink1
[   11.123073] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   11.123075] iwlwifi 0000:00:14.3: 0x00000006 | umac data1
[   11.123076] iwlwifi 0000:00:14.3: 0x00000001 | umac data2
[   11.123077] iwlwifi 0000:00:14.3: 0x00FF0FFF | umac data3
[   11.123078] iwlwifi 0000:00:14.3: 0x00000048 | umac major
[   11.123079] iwlwifi 0000:00:14.3: 0xDAA05125 | umac minor
[   11.123080] iwlwifi 0000:00:14.3: 0x00532FFD | frame pointer
[   11.123081] iwlwifi 0000:00:14.3: 0xC0886BC8 | stack pointer
[   11.123083] iwlwifi 0000:00:14.3: 0x0059050F | last host cmd
[   11.123084] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   11.123105] iwlwifi 0000:00:14.3: IML/ROM dump:
[   11.123106] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   11.123115] iwlwifi 0000:00:14.3: 0x00005644 | IML/ROM data1
[   11.123123] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   11.123130] iwlwifi 0000:00:14.3: Fseq Registers:
[   11.123133] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   11.123136] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[   11.123158] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
[   11.123161] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[   11.123164] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[   11.123167] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   11.123170] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   11.123173] iwlwifi 0000:00:14.3: 0x00000501 | FSEQ_CNVR_ID
[   11.123176] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   11.123181] iwlwifi 0000:00:14.3: 0x00000501 | CNVR_AUX_MISC_CHIP
[   11.123187] iwlwifi 0000:00:14.3: 0x05B0905B |=20
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   11.123210] iwlwifi 0000:00:14.3: 0x0000025B |=20
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   11.123316] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fi=
red=20
(delay=3D0ms).
[   11.123323] ieee80211 phy0: Hardware restart was requested
[   11.123335] iwlwifi 0000:00:14.3: FW error in SYNC CMD ADD_STA
[   11.123339] CPU: 2 PID: 454 Comm: kworker/u8:7 Not tainted 6.2.0-rc4-
MANJARO+ #1 1f3d836209aeeec227dbaeb521deffb09cfcace0
[   11.123343] Hardware name: AZW EQ59/EQ59, BIOS JTKT001 11/30/2022
[   11.123345] Workqueue: phy0 ieee80211_iface_work [mac80211]
[   11.123412] Call Trace:
[   11.123415]  <TASK>
[   11.123431]  dump_stack_lvl+0x48/0x60
[   11.123439]  iwl_trans_txq_send_hcmd+0x442/0x450 [iwlwifi=20
69290b552889242f0d96c439f0b6158cc98fa0d7]
[   11.123470]  ? __pfx_autoremove_wake_function+0x10/0x10
[   11.123474]  iwl_trans_send_cmd+0x98/0x100 [iwlwifi=20
69290b552889242f0d96c439f0b6158cc98fa0d7]
[   11.123498]  iwl_mvm_send_cmd_status+0x37/0xd0 [iwlmvm=20
517de8313741ff37e726c9b99db55c0d6603dc22]
[   11.123527]  iwl_mvm_send_cmd_pdu_status+0x59/0x80 [iwlmvm=20
517de8313741ff37e726c9b99db55c0d6603dc22]
[   11.123547]  iwl_mvm_sta_send_to_fw+0x234/0x420 [iwlmvm=20
517de8313741ff37e726c9b99db55c0d6603dc22]
[   11.123569]  iwl_mvm_mac_sta_state+0x45e/0x880 [iwlmvm=20
517de8313741ff37e726c9b99db55c0d6603dc22]
[   11.123588]  drv_sta_state+0x85/0x540 [mac80211=20
ea0db9f0fa9d1f72ccbb1f340690b1485cbf2b82]
[   11.123641]  sta_info_move_state+0x227/0x2a0 [mac80211=20
ea0db9f0fa9d1f72ccbb1f340690b1485cbf2b82]
[   11.123691]  ieee80211_rx_mgmt_assoc_resp.cold+0x5c3/0x18ee [mac80211=20
ea0db9f0fa9d1f72ccbb1f340690b1485cbf2b82]
[   11.123755]  ieee80211_sta_rx_queued_mgmt+0x2b8/0x7e0 [mac80211=20
ea0db9f0fa9d1f72ccbb1f340690b1485cbf2b82]
[   11.123816]  ? psi_task_switch+0xd6/0x230
[   11.123819]  ? __switch_to_asm+0x3e/0x80
[   11.123822]  ? finish_task_switch.isra.0+0x90/0x2d0
[   11.123826]  ? __schedule+0x3bc/0x12e0
[   11.123828]  ieee80211_iface_work+0x325/0x450 [mac80211=20
ea0db9f0fa9d1f72ccbb1f340690b1485cbf2b82]
[   11.123884]  process_one_work+0x1c5/0x380
[   11.123888]  worker_thread+0x51/0x390
[   11.123891]  ? __pfx_worker_thread+0x10/0x10
[   11.123893]  kthread+0xdb/0x110
[   11.123895]  ? __pfx_kthread+0x10/0x10
[   11.123897]  ret_from_fork+0x29/0x50
[   11.123902]  </TASK>
[   11.123926] wlo1: failed to move station xx:xx:xx:xx:xx:xx to desired st=
ate
[   11.506067] iwlwifi 0000:00:14.3: Failed to trigger RX queues sync (-5)
[   11.523821] iwlwifi 0000:00:14.3: Couldn't send the SESSION_PROTECTION_C=
MD:=20
=2D5
[   11.523899] iwlwifi 0000:00:14.3: Failed to send MAC context (action:2):=
 -5
[   11.523903] iwlwifi 0000:00:14.3: failed to update MAC xx:xx:xx:xx:xx:xx
[   11.523912] iwlwifi 0000:00:14.3: Failed to send binding (action:3): -5
[   11.523916] iwlwifi 0000:00:14.3: Failed to send MAC context (action:2):=
 -5
[   11.523918] iwlwifi 0000:00:14.3: failed to update MAC xx:xx:xx:xx:xx:xx
[   11.523921] iwlwifi 0000:00:14.3: PHY ctxt cmd error. ret=3D-5
[   11.858003] wlo1: authenticate with xx:xx:xx:xx:xx:xx
[   11.858027] wlo1: 80 MHz not supported, disabling VHT
[   11.861004] wlo1: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
[   11.889135] wlo1: authenticated
[   11.890299] wlo1: associate with xx:xx:xx:xx:xx:xx (try 1/3)
[   11.946307] wlo1: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1031=20
status=3D0 aid=3D13)
[   11.950064] wlo1: associated
[   11.987866] wlo1: Limiting TX power to 27 (27 - 0) dBm as advertised by=
=20
xx:xx:xx:xx:xx:xx
[   12.137558] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready

--nextPart5642384.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEENSNFoSpoTSrmxF9vGvlck5mKYvIFAmPKSlUACgkQGvlck5mK
YvKzwgf8DeDh7rlaRKKniVEioQQMMYjIxzBvoMt7+RdQaFj8FKtW2IUVnTeVDeuo
+a2JxVNsmEhi7i3UdjWQPWUm74n5AiSX3BbyhXzfnRO+a7HOddcnD0TGAqP7ZI/r
5Ntnun2pjwSyWgMbFM6SstHSYorim8ewaRbXvI5w6780lcfQTmXXajZNXGG0Shca
nnXqUEyFQq2gyJUPFwQTQjnndzs5bJH+VOMTAhftfNPEZywrf6qI1UI56xE/Qdp9
0I3BlNCmqoexDrLpALmjwcdyKfjuZni4/bhE1Kx5kvWzB7SNcRV9Sp3iduYqmlEB
0jKPQPV3kwKmGm5vnD4DIfSPGzb1cA==
=deIO
-----END PGP SIGNATURE-----

--nextPart5642384.DvuYhMxLoT--




Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070D476B8C1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjHAPid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 11:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjHAPic (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 11:38:32 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB5BF;
        Tue,  1 Aug 2023 08:38:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFf6f2XJTz9xFr9;
        Tue,  1 Aug 2023 23:24:42 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.206.119])
        by APP1 (Coremail) with SMTP id LxC2BwA36biWJslk2IYdAA--.14146S5;
        Tue, 01 Aug 2023 16:37:47 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        SHA-cyfmac-dev-list@infineon.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1 3/3] wifi: brcm80211: change channel_list to a flexible array
Date:   Tue,  1 Aug 2023 17:36:42 +0200
Message-Id: <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LxC2BwA36biWJslk2IYdAA--.14146S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4DtFW7Ar4UuFWxCrW3ZFb_yoW3tr1Dpa
        4fXa4jkr4kXr4a9a1UJFs5JFyrKanFy3WDKFWIy3sa9a1Uur1xJF10kFy09ry5C397t3sF
        vF4jqryUKFsFyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnI
        WIevJa73UjIFyTuYvjfU8F4EDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The channel list is in fact a flexible array, but it has a length of 1 to
make sure there is enough room for the special chanspec -1 when the struct
is allocated on stack to abort a scan.

Move the single array member to newly declared struct brcmf_scan_abort_le
and struct brcmf_scan_abort_v2_le and make channel_list in struct
brcmf_scan_params_le and struct brcmf_scan_params_v2_le a flexible array.

This fixes this annoying (though harmless) warning when the kernel is built
with CONFIG_FORTIFY_SOURCE=3Dy:

------------[ cut here ]------------
memcpy: detected field-spanning write (size 76) of single field "&params_le=
->channel_list[0]" at drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg8=
0211.c:1072 (size 2)
WARNING: CPU: 2 PID: 991 at drivers/net/wireless/broadcom/brcm80211/brcmfma=
c/cfg80211.c:1072 brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
Modules linked in: qrtr(E) algif_hash(E) aes_neon_bs(E) aes_neon_blk(E) alg=
if_skcipher(E) af_alg(E) bnep(E) brcmfmac_wcc(E) bcm2835_v4l2(CE) bcm2835_m=
mal_vchiq(CE) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) vi=
deodev(E) hci_uart(E) btsdio(E) videobuf2_common(E) btbcm(E) mc(E) snd_bcm2=
835(CE) bluetooth(E) snd_pcm(E) brcmfmac(E) snd_timer(E) cpufreq_dt(E) snd(=
E) soundcore(E) cfg80211(E) ecdh_generic(E) brcmutil(E) raspberrypi_cpufreq=
(E) rfkill(E) vchiq(CE) bcm2711_thermal(E) leds_gpio(E) fuse(E) efi_pstore(=
E) dmi_sysfs(E) ip_tables(E) x_tables(E) rpcsec_gss_krb5(E) auth_rpcgss(E) =
nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) fscache(E) netfs(E) af_pa=
cket(E) mmc_block(E) xhci_pci(E) xhci_pci_renesas(E) xhci_hcd(E) usbcore(E)=
 usb_common(E) clk_raspberrypi(E) gpio_raspberrypi_exp(E) bcm2835_dma(E) cr=
ct10dif_ce(E) virt_dma(E) pcie_brcmstb(E) sdhci_iproc(E) gpio_regulator(E) =
sdhci_pltfm(E) sdhci(E) mmc_core(E) fixed(E) nvmem_rmem(E) sunrpc(E) sg(E) =
dm_multipath(E) dm_mod(E) efivarfs(E)
Unloaded tainted modules: aes_ce_cipher(E):1
CPU: 2 PID: 991 Comm: wpa_supplicant Tainted: G         C  E      6.5.0-rc4=
-dynswiotlb+ #27 2ec0961165cc91fdbec101d9d43b3331ba4f0927
Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04 04/01/=
2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
lr : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
sp : ffff8000829ab590
x29: ffff8000829ab590 x28: 0000000000000000 x27: 0000000000000001
x26: ffff000105e7e0a4 x25: ffff00010a0bcb48 x24: ffff000101e03800
x23: ffff000105ec8920 x22: ffff000106332980 x21: ffff00010a0bc0c0
x20: ffff00010a0bcb90 x19: ffff00010a0bc108 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 616f72622f737365
x14: 6c657269772f7465 x13: 616d666d6372622f x12: 31313230386d6372
x11: 00000000ffffdfff x10: ffff800081ad3328 x9 : ffff800080130694
x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
x5 : ffff0001fef75e00 x4 : 0000000000000000 x3 : 0000000000000027
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00010aa0e000
Call trace:
 brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac 38c4a81a3b85b4aff1650c67f9=
5f20bc542d60c1]
 brcmf_run_escan+0x148/0x1a0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d=
60c1]
 brcmf_do_escan+0x74/0xe0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d60c=
1]
 brcmf_cfg80211_scan+0xcc/0x298 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc5=
42d60c1]
 rdev_scan+0x38/0x158 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54cb8]
 cfg80211_scan+0x134/0x178 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54c=
b8]
 nl80211_trigger_scan+0x3e8/0x768 [cfg80211 8907673111c49ec56be88af3d38994c=
c1cf54cb8]
 genl_family_rcv_msg_doit.isra.0+0xc0/0x130
 genl_rcv_msg+0x1e4/0x278
 netlink_rcv_skb+0x64/0x138
 genl_rcv+0x40/0x60
 netlink_unicast+0x1cc/0x2d8
 netlink_sendmsg+0x1d4/0x448
 sock_sendmsg+0x64/0xc0
 ____sys_sendmsg+0x260/0x2e0
 ___sys_sendmsg+0x88/0xf0
 __sys_sendmsg+0x70/0xd8
 __arm64_sys_sendmsg+0x2c/0x40
 invoke_syscall+0x78/0x100
 el0_svc_common.constprop.0+0x100/0x130
 do_el0_svc+0x40/0xa8
 el0_svc+0x34/0x138
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x1a8/0x1b0
---[ end trace 0000000000000000 ]---

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 22 ++++++++++---------
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 14 ++++++++++--
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 3f4257fe76b3..337a8e915e94 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1088,8 +1088,9 @@ static void brcmf_escan_base_prep(struct brcmf_scan_p=
arams_v2_le *params_le)
 	memset(&params_le->ssid_le, 0, sizeof(params_le->ssid_le));
 }
=20
-static void brcmf_escan_abort_prep(struct brcmf_scan_params_v2_le *params_=
le)
+static void brcmf_escan_abort_prep(struct brcmf_scan_abort_v2_le *abort_le)
 {
+	struct brcmf_scan_params_v2_le *params_le =3D &abort_le->params;
 	int length =3D BRCMF_SCAN_PARAMS_V2_FIXED_SIZE + sizeof(u16);
=20
 	brcmf_escan_base_prep(params_le);
@@ -1171,7 +1172,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211=
_info *cfg,
 				bool fw_abort)
 {
 	struct brcmf_pub *drvr =3D cfg->pub;
-	struct brcmf_scan_params_v2_le params_v2_le;
+	struct brcmf_scan_abort_v2_le abort_v2_le;
 	struct cfg80211_scan_request *scan_request;
 	u64 reqid;
 	u32 bucket;
@@ -1191,20 +1192,21 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg802=
11_info *cfg,
 		/* Do a scan abort to stop the driver's scan engine */
 		brcmf_dbg(SCAN, "ABORT scan in firmware\n");
=20
-		brcmf_escan_abort_prep(&params_v2_le);
+		brcmf_escan_abort_prep(&abort_v2_le);
=20
-		/* E-Scan (or anyother type) can be aborted by SCAN */
+		/* E-Scan (or any other type) can be aborted by SCAN */
 		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
 			err =3D brcmf_fil_cmd_data_set(ifp, BRCMF_C_SCAN,
-						     &params_v2_le,
-						     sizeof(params_v2_le));
+						     &abort_v2_le,
+						     sizeof(abort_v2_le));
 		} else {
-			struct brcmf_scan_params_le params_le;
+			struct brcmf_scan_abort_le abort_le;
=20
-			brcmf_scan_params_v2_to_v1(&params_v2_le, &params_le);
+			brcmf_scan_params_v2_to_v1(&abort_v2_le.params,
+						   &abort_le.params);
 			err =3D brcmf_fil_cmd_data_set(ifp, BRCMF_C_SCAN,
-						     &params_le,
-						     sizeof(params_le));
+						     &abort_le,
+						     sizeof(abort_le));
 		}
=20
 		if (err)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 792adaf880b4..10cc80b56f25 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -398,7 +398,12 @@ struct brcmf_scan_params_le {
 				 * fixed parameter portion is assumed, otherwise
 				 * ssid in the fixed portion is ignored
 				 */
-	__le16 channel_list[1];	/* list of chanspecs */
+	__le16 channel_list[];	/* list of chanspecs */
+};
+
+struct brcmf_scan_abort_le {
+	struct brcmf_scan_params_le params;
+	__le16 channel_list[1];	/* room for the special chanspec -1 */
 };
=20
 struct brcmf_scan_params_v2_le {
@@ -437,7 +442,12 @@ struct brcmf_scan_params_v2_le {
 				 * fixed parameter portion is assumed, otherwise
 				 * ssid in the fixed portion is ignored
 				 */
-	__le16 channel_list[1];	/* list of chanspecs */
+	__le16 channel_list[];	/* list of chanspecs */
+};
+
+struct brcmf_scan_abort_v2_le {
+	struct brcmf_scan_params_v2_le params;
+	__le16 channel_list[1];	/* room for the special chanspec -1 */
 };
=20
 struct brcmf_scan_results {
--=20
2.25.1


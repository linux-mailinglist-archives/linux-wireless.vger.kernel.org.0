Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3540610F271
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 22:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLBV5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 16:57:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37142 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbfLBV5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 16:57:09 -0500
Received: from localhost (DEPARTMENT-OF-ALCHEMY.MIT.EDU [18.9.64.20])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB2Luxhh009754;
        Mon, 2 Dec 2019 16:56:59 -0500
Date:   Mon, 2 Dec 2019 16:56:59 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: [PATCH v1.1] Revert "iwlwifi: assign directly to iwl_trans->cfg in
 QuZ detection"
In-Reply-To: <alpine.DEB.2.21.999.1912010127330.108936@department-of-alchemy.mit.edu>
Message-ID: <alpine.DEB.2.21.999.1912021653360.21300@department-of-alchemy.mit.edu>
References: <alpine.DEB.2.21.999.1912010127330.108936@department-of-alchemy.mit.edu>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152179776-2109016470-1575323819=:21300"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152179776-2109016470-1575323819=:21300
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE

This reverts commit 968dcfb4905245dc64d65312c0d17692fa087b99.

Both that commit and commit 809805a820c6445f7a701ded24fdc6bbc841d1e4
attempted to fix the same bug (dead assignments to the local variable
cfg), but they did so in incompatible ways. When they were both merged,
independently of each other, the combination actually caused the bug to
reappear, leading to a firmware crash on boot for some cards.

https://bugzilla.kernel.org/show_bug.cgi?id=3D205719

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
[Re-sending without format=3Dflowed damage. Sorry about that, it=A2s been a
while!]

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wi=
reless/intel/iwlwifi/pcie/drv.c
index 040cec17d3ad..b0b7eca1754e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1109,22 +1109,22 @@ static int iwl_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 =09=09=09cfg =3D &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
 =09}

 =09/* same thing for QuZ... */
 =09if (iwl_trans->hw_rev =3D=3D CSR_HW_REV_TYPE_QUZ) {
-=09=09if (iwl_trans->cfg =3D=3D &iwl_ax101_cfg_qu_hr)
-=09=09=09iwl_trans->cfg =3D &iwl_ax101_cfg_quz_hr;
-=09=09else if (iwl_trans->cfg =3D=3D &iwl_ax201_cfg_qu_hr)
-=09=09=09iwl_trans->cfg =3D &iwl_ax201_cfg_quz_hr;
-=09=09else if (iwl_trans->cfg =3D=3D &iwl9461_2ac_cfg_qu_b0_jf_b0)
-=09=09=09iwl_trans->cfg =3D &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-=09=09else if (iwl_trans->cfg =3D=3D &iwl9462_2ac_cfg_qu_b0_jf_b0)
-=09=09=09iwl_trans->cfg =3D &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
-=09=09else if (iwl_trans->cfg =3D=3D &iwl9560_2ac_cfg_qu_b0_jf_b0)
-=09=09=09iwl_trans->cfg =3D &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-=09=09else if (iwl_trans->cfg =3D=3D &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-=09=09=09iwl_trans->cfg =3D &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
+=09=09if (cfg =3D=3D &iwl_ax101_cfg_qu_hr)
+=09=09=09cfg =3D &iwl_ax101_cfg_quz_hr;
+=09=09else if (cfg =3D=3D &iwl_ax201_cfg_qu_hr)
+=09=09=09cfg =3D &iwl_ax201_cfg_quz_hr;
+=09=09else if (cfg =3D=3D &iwl9461_2ac_cfg_qu_b0_jf_b0)
+=09=09=09cfg =3D &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
+=09=09else if (cfg =3D=3D &iwl9462_2ac_cfg_qu_b0_jf_b0)
+=09=09=09cfg =3D &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
+=09=09else if (cfg =3D=3D &iwl9560_2ac_cfg_qu_b0_jf_b0)
+=09=09=09cfg =3D &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
+=09=09else if (cfg =3D=3D &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+=09=09=09cfg =3D &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 =09}

 #endif
 =09/* now set the real cfg we decided to use */
 =09iwl_trans->cfg =3D cfg;
--=20
2.24.0

--152179776-2109016470-1575323819=:21300--

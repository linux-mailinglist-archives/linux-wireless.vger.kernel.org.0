Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBF268309
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 05:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINDQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Sep 2020 23:16:51 -0400
Received: from mail-bn7nam10on2097.outbound.protection.outlook.com ([40.107.92.97]:49856
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgINDQt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Sep 2020 23:16:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe/a6dnqOo5W6LqXSSRFqdGox2723sFbqgNpV3AzsCarKflsrRiZtX0l+L1DNTaMa1U9THz4oSBO7SZoaQszFnbcpP0HWX1cmM8HQT7l2xbqHeayedc8nkSD6q0W4UoqWtgjru5RYtiBjYKIchcYPkvmlmvY1iqP1n7EOLQMAbV0aq4yCSJe2KEAmA2aB78W3Zdv9TDkbt6VeG41sKy51qqp/PCuxq9QTOyRHraWjsRF4Zmr1nqx2QU2M0HIkOVroiq7KgAJpUY0macElDpokjfFXvgsENCfB3dhmPJIqhaFLctxlPNYPKsDfUzMT8/QQTcDQyypI3d7RTCdGEGW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBECv4wwJI3jZL7sj2f6BRUqLTi0d6gB1Lbd0luK91g=;
 b=RzT2zRUQBWW6fCd9ibLd3HsAik6pFyfFOyhJYGVuQXxewpIBszrPksZN2gZKtHYZ8qvc6Me+o9TE99eOWLcvObg8L5E46ukXOumumgWuyw7yBm+5hZdfbpWaYDejuoUSSG+c1aOu9RMDkuOPtDqOWdfS4pDi9hzjdtPBvIlmBSoaJ6C+xtNfxFwjB4CbOaWftw3eHb/yI0KQ1MFK/7MP04FUC/jotCSRVRSNrarVEeWXcd3JhUIPyhIqVrL/BilBQmAN5X6U8xIx8RMHpZMDStOdrU/WWLxBu2vLgim7KYpw5zbgnspktla/ZiaCtriVVSy/qTOIPiI8GSIgn+odqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBECv4wwJI3jZL7sj2f6BRUqLTi0d6gB1Lbd0luK91g=;
 b=VrPRP0krhjPDTDQfsw8FW2yKpDgVbwiCEG1uKkreEUUlXW/hasXmqH867E1A6z0955gDhHxcbdzq6fK72qwDi4L7cw76v3gp5bAKqd4JWkIv6H8VC7p28j1WLdua05z5d2hi7j1YEtMawYjSNljevyil8HSBWwP3PxFDD9tNvRw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5377.namprd06.prod.outlook.com (2603:10b6:408:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 03:16:47 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 03:16:47 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        "Double Lo" <double.lo@cypress.com>
Subject: [PATCH v2 1/3] brcmfmac: support virtual interface creation from firmware
Date:   Sun, 13 Sep 2020 22:16:32 -0500
Message-Id: <20200914031634.190721-2-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200914031634.190721-1-wright.feng@cypress.com>
References: <20200914031634.190721-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 03:16:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2aa87ff0-b806-489d-60ff-08d8585c9d17
X-MS-TrafficTypeDiagnostic: BN8PR06MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB5377CF75B5D509462A8D123AFB230@BN8PR06MB5377.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCV+ONLrbm3wSNAlrKZnHxO6ESrxxLeDh2y6u9+Hu7YFfleeAmMkNDBoAfm8egR+wY6XOcPKoxEY+nIrNqRSlm8nvXq0DBS68SgZT/PfTI7x85NRJ+Y1+fnsgwWbgCcZZzCvr5BOVkAOi9TVNI0+W7I8yuMKa/a6bsmgYn4xdqje/Nb08vZttPtl7Db3sdWx1cjxSV3M+OgtQGMArgG6TBaDzz/6Hkb6keMcomFCCN+cu0un6rNySiTYzOjZMYHg6pxYLldh+BtrkkBA9SGIqVZOl0B0dhhfHUcx6ZjQgKka2t9i/3Hi74H4i/n89EL1n9rZyGyMzvUm4Gb11NX8Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(36756003)(26005)(7696005)(52116002)(6916009)(6486002)(66556008)(66476007)(1076003)(83380400001)(86362001)(16526019)(66946007)(186003)(4326008)(8936002)(8676002)(44832011)(2906002)(478600001)(316002)(54906003)(2616005)(956004)(5660300002)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ytrBjW0yg45WLzxStmt5znGs60gbnMgztrLuy1fSJT8w/VoRM+H1zrFbVXTX4qVkap5Wf+1u4l8EufKGvNCWF9fooCWHsKzAHiGcPi2FYwE/0IHPJRr/BedSotUpoMYqQmzsVVH65u89RAKBEX55qfx6Vt8eZgg08oW+G7DfQ1iB9zs4mhW9f/vKat4ua5yE1dQIqTQf7NT2fHwqQAW1F8LNmakJPrXTCyhj4vPrtTZodA51iT4hJWMlNaf8jMOl5MobUkj7WaFDIOrR87JDIMhE5tLMGe+hAykdWsKlt0crgR0Veudca0W3elySVNSl0YeMuU8MtLD7i/1AOsZEbt82h3V21Uz/9NuMKqEJVCG79FDrTQtcOrn85it0p9G7jx6TuDdS6IzaGfuJTrzP404LIkr6AdplFiGYDKTF+XVxtCtBvxXjV7UvVQ8XNBU/ZPrxNK6IkfOM5arRo8CoPyrQgGGZamSXrwyfv9abnIRyMqsYluJN6UBT4pY0H7Ia8hQTltz8tWgJURjH2m6/eSjUCea3KX11QDCf+wTe0o1xdrBHdxwnwb9p2vgV59YHU7CED5Kpc/KMFnHsQwTANsEqK26Av7piUUOQC8ocViStIW1RM2OJYyC+pXdmEOjKzvil7vbfbADYJZvnT4QEJg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa87ff0-b806-489d-60ff-08d8585c9d17
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 03:16:47.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts0MNWGNc8B0LHRBE3CCAV7YkxHPo2d0CdcpiwGvmJHN1bNO/akewJVekLj2hOo8AxMBdju8XF5qIwR7LJWlDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5377
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Double Lo" <double.lo@cypress.com>

Allow interface creation via IF_ADD event from firmware.

Signed-off-by: Double Lo <double.lo@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 50 +++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5d99771c3f64..c0177e121526 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -230,6 +230,9 @@ struct parsed_vndr_ies {
 	struct parsed_vndr_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
 };
 
+#define WLC_E_IF_ROLE_STA		0	/* Infra STA */
+#define WLC_E_IF_ROLE_AP		1	/* Access Point */
+
 static u8 nl80211_band_to_fwil(enum nl80211_band band)
 {
 	switch (band) {
@@ -5535,8 +5538,10 @@ void brcmf_cfg80211_free_netdev(struct net_device *ndev)
 	ifp = netdev_priv(ndev);
 	vif = ifp->vif;
 
-	if (vif)
+	if (vif) {
 		brcmf_free_vif(vif);
+		ifp->vif = NULL;
+	}
 }
 
 static bool brcmf_is_linkup(struct brcmf_cfg80211_vif *vif,
@@ -6102,6 +6107,9 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *ifp,
 	struct brcmf_if_event *ifevent = (struct brcmf_if_event *)data;
 	struct brcmf_cfg80211_vif_event *event = &cfg->vif_event;
 	struct brcmf_cfg80211_vif *vif;
+	enum nl80211_iftype iftype = NL80211_IFTYPE_UNSPECIFIED;
+	bool vif_pend = false;
+	int err;
 
 	brcmf_dbg(TRACE, "Enter: action %u flags %u ifidx %u bsscfgidx %u\n",
 		  ifevent->action, ifevent->flags, ifevent->ifidx,
@@ -6114,9 +6122,30 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *ifp,
 	switch (ifevent->action) {
 	case BRCMF_E_IF_ADD:
 		/* waiting process may have timed out */
-		if (!cfg->vif_event.vif) {
-			spin_unlock(&event->vif_event_lock);
-			return -EBADF;
+		if (!vif) {
+			/* handle IF_ADD event from firmware */
+			vif_pend = true;
+			if (ifevent->role == WLC_E_IF_ROLE_STA)
+				iftype = NL80211_IFTYPE_STATION;
+			else if (ifevent->role == WLC_E_IF_ROLE_AP)
+				iftype = NL80211_IFTYPE_AP;
+			else
+				vif_pend = false;
+
+			if (vif_pend) {
+				spin_unlock(&event->vif_event_lock);
+				vif = brcmf_alloc_vif(cfg, iftype);
+				if (IS_ERR(vif)) {
+					brcmf_err("Role:%d failed to alloc vif\n",
+						  ifevent->role);
+					return PTR_ERR(vif);
+				}
+				spin_lock(&event->vif_event_lock);
+			} else {
+				brcmf_err("Invalid Role:%d\n", ifevent->role);
+				spin_unlock(&event->vif_event_lock);
+				return -EBADF;
+			}
 		}
 
 		ifp->vif = vif;
@@ -6126,6 +6155,19 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *ifp,
 			ifp->ndev->ieee80211_ptr = &vif->wdev;
 			SET_NETDEV_DEV(ifp->ndev, wiphy_dev(cfg->wiphy));
 		}
+
+		if (vif_pend) {
+			err = brcmf_net_attach(ifp, false);
+			if (err) {
+				brcmf_err("netdevice register failed with err:%d\n",
+					  err);
+				brcmf_free_vif(vif);
+				free_netdev(ifp->ndev);
+			}
+			spin_unlock(&event->vif_event_lock);
+			return err;
+		}
+
 		spin_unlock(&event->vif_event_lock);
 		wake_up(&event->vif_wq);
 		return 0;
-- 
2.25.0


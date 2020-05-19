Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBE1D94F0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgESLK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:10:26 -0400
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com ([40.107.237.135]:17729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgESLKZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQxRVwsDv6ReGOS9c9ChuoITqxZjVC+13bDvurJtIKOa41C42yFs7nU6c44O3XOKVLMYts8Ks6zKL2UxYky668AjflqK6OxlNjPvW6jCpzICcsJTwpYpungWfXfgXqfmgLVi+iL4Lod1Shdevr9spFPD6m0HsAcV6hSIvUWDY0zPphfgYRn7BaXWTaRF/WMpUmAH3KZnW21Rn1axWSm0salWQZwTUbqwQbfiRuaArBA4KPgW9JP/M5BjGuR43zYUvKnXTY87xshrXpi/47NrMwgIauWj2RMwuMOyhFAcH8995dQ10VxJFx6mYpgBNtxCtE/yam9m2ZTqGCgsML02XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFl4eDshnBc9/N4YSvMdg/4KOiru8DQ+T8l5ylSAme0=;
 b=bWo77YM3Tk6KZsw1x7wFe/XHR999S4a0jIHAh9A2xHFvYXAwD8n98gwxQe0ruf44TNqnuKNKwuWBSB5to4OrhwEv1qd2fsrE1ZFHBj3xFjCDmA1JbjGcfUJh6wIvhl2nyNAefQfAjVNAWOCG2iU4XxpcpANlCgamYYMha1SjsgKx3xadFZ0ygNkGDntnjDAJ3pbvQQlkU+Lt44ZmwU2Rv4bn7t3KbWwMPZ6Ke3gZl2dLcJIDpZ5T5IwUpOmP5NzBmUtmg0hQ2pwPA1OSH/Vr8t6AypcpBr8/2ju5fVimIH8ouaJXKp606PpJO/R8ibpsj9UYCv9hZqmOp8IMChKfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFl4eDshnBc9/N4YSvMdg/4KOiru8DQ+T8l5ylSAme0=;
 b=GV+OiX0sNeZyXoMLbtugCJpV9cCslLpL8SwnzdUiGOpKaJxSkIoq+KUOsXQRiZE/zt4Ewp3Irj4AYGEI69TVPe97hvX+9mIPCCpzg/smK7xY0obBsTl0GuZOgAF6qp1FoMjtluhgYP2iB7FWyqk6DYhNmqw9Vg8ZpO19q27TTTI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4906.namprd06.prod.outlook.com (2603:10b6:5:56::11) by
 DM6PR06MB6043.namprd06.prod.outlook.com (2603:10b6:5:10b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Tue, 19 May 2020 11:10:18 +0000
Received: from DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f]) by DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:10:17 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/4] brcmfmac: support virtual interface creation from firmware
Date:   Tue, 19 May 2020 06:09:49 -0500
Message-Id: <20200519110951.88998-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To DM6PR06MB4906.namprd06.prod.outlook.com
 (2603:10b6:5:56::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:10:02 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e3b10d4-5e37-4ecf-e669-08d7fbe52e2a
X-MS-TrafficTypeDiagnostic: DM6PR06MB6043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB604399319C07EE46E3E674F4BBB90@DM6PR06MB6043.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlKQTM7NbWIsSbHWhUh8Fz4oaLt/Fu10vRRYvLy5N9vJNpnIYBh9Cq36B/tsmpFyjfnrBsxXXUPfUilNspAa9BPCen5C5eGDxYfoalK9ZBTRgNCfAl+UbzduEJALJKo9aCjujiLOyrovxXqGcaNZB9mtpf79xv6rj3UfWybySaj6GkvHLsESufD93pAYzWHbAvoOGUqSBY+SRDWFwdiFBYB6fshwV8KQHRqn3lBNbXziUnwZOQlEL5HxnL2Jx+okmAZ10+BKTwiovRsf/kb+2F2QQRru/e1P7m31FgT5yid9Amag0wwxfZYjT0Ey6sGqfhUgK8tqtjMYgLUQWrAi0POTG+ZCU1ucE3zlAQF73txMvyKiNfG0YVNt4G07J5/HxK0izyg6bnsgnK0g8kiuss8qoN6COSj/+GDG2N3mQ1V14wTby2oTyXMftRzdptPS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4906.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(52116002)(66946007)(66556008)(86362001)(36756003)(7696005)(54906003)(66476007)(8936002)(8676002)(6916009)(478600001)(956004)(316002)(2616005)(6486002)(1076003)(5660300002)(6666004)(2906002)(4326008)(186003)(16526019)(107886003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XNuOkqvPQDUjEoxCtXlCNJh/lTqEj+l78QquKZGQgCOhY+k2kUmdWWvyRcmEI1BV5PAo759s+W55by4yp+d+cw0W5ONtlIsoZ5puRMkPfhAisCepSYB+COBF4yrz92MTq2aOC2Hzxu827siH32ik80g3jOXUWr1IqDwP823JN4Ps6elZ51+x/FFG/V0Ir711hKmNSuRWf0pxgJi3xKqwNALSmI70X3nIwPf4scA3p5uCbAfoCh8zZ4IUgpIjA86fpB6ZDUB/dCDw91cWYuMmhYdn1CzqgBZJbgdjJwzYfRNS7cYekvaxpTXT8tFodumYLl2QMIvIrmUbOyQ/w9J0obN7yw+nsxn+Tv3UTLMxElCKpHTV4QRnDQhJrZq35AabxmjoXdC2tZtfK4vMittNHxsdOp6XJg66IJ8hxfaQIJGOzyUXEb9wS0+VaW3zJQf+hfIMiNABxj5W9drPnjStydEYjamS1NdSEblVgv/nsHVhyLyUR3aIb9QrmA3jQF/i
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3b10d4-5e37-4ecf-e669-08d7fbe52e2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:10:04.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh799I7tkkY7kNEdICkKBLp5V4WhP5Bp4tOY5KVFT3jru/ygTXXwJHyoJJOo4tchetyBDfmPdS1q4XplC8hh3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6043
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

Allow interface creation via IF_ADD event from firmware.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 46 +++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a757abd7a599..900376dc0b67 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -230,6 +230,9 @@ struct parsed_vndr_ies {
        struct parsed_vndr_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
 };

+#define WLC_E_IF_ROLE_STA              0       /* Infra STA */
+#define WLC_E_IF_ROLE_AP               1       /* Access Point */
+
 static u8 nl80211_band_to_fwil(enum nl80211_band band)
 {
        switch (band) {
@@ -5532,8 +5535,10 @@ void brcmf_cfg80211_free_netdev(struct net_device *n=
dev)
        ifp =3D netdev_priv(ndev);
        vif =3D ifp->vif;

-       if (vif)
+       if (vif) {
                brcmf_free_vif(vif);
+               ifp->vif =3D NULL;
+       }
 }

 static bool brcmf_is_linkup(struct brcmf_cfg80211_vif *vif,
@@ -6090,6 +6095,9 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *if=
p,
        struct brcmf_if_event *ifevent =3D (struct brcmf_if_event *)data;
        struct brcmf_cfg80211_vif_event *event =3D &cfg->vif_event;
        struct brcmf_cfg80211_vif *vif;
+       enum nl80211_iftype iftype =3D NL80211_IFTYPE_UNSPECIFIED;
+       bool vif_pend =3D false;
+       int err;

        brcmf_dbg(TRACE, "Enter: action %u flags %u ifidx %u bsscfgidx %u\n=
",
                  ifevent->action, ifevent->flags, ifevent->ifidx,
@@ -6102,9 +6110,28 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *i=
fp,
        switch (ifevent->action) {
        case BRCMF_E_IF_ADD:
                /* waiting process may have timed out */
-               if (!cfg->vif_event.vif) {
+               if (!vif) {
+                       /* handle IF_ADD event from firmware */
                        spin_unlock(&event->vif_event_lock);
-                       return -EBADF;
+                       vif_pend =3D true;
+                       if (ifevent->role =3D=3D WLC_E_IF_ROLE_STA)
+                               iftype =3D NL80211_IFTYPE_STATION;
+                       else if (ifevent->role =3D=3D WLC_E_IF_ROLE_AP)
+                               iftype =3D NL80211_IFTYPE_AP;
+                       else
+                               vif_pend =3D false;
+
+                       if (vif_pend) {
+                               vif =3D brcmf_alloc_vif(cfg, iftype);
+                               if (IS_ERR(vif)) {
+                                       brcmf_err("Role:%d failed to alloc =
vif\n",
+                                                 ifevent->role);
+                                       return PTR_ERR(vif);
+                               }
+                       } else {
+                               brcmf_err("Invalid Role:%d\n", ifevent->rol=
e);
+                               return -EBADF;
+                       }
                }

                ifp->vif =3D vif;
@@ -6114,6 +6141,19 @@ static s32 brcmf_notify_vif_event(struct brcmf_if *i=
fp,
                        ifp->ndev->ieee80211_ptr =3D &vif->wdev;
                        SET_NETDEV_DEV(ifp->ndev, wiphy_dev(cfg->wiphy));
                }
+
+               if (vif_pend) {
+                       err =3D brcmf_net_attach(ifp, false);
+                       if (err) {
+                               brcmf_err("netdevice register failed with e=
rr:%d\n",
+                                         err);
+                               brcmf_free_vif(vif);
+                               free_netdev(ifp->ndev);
+                       }
+                       spin_unlock(&event->vif_event_lock);
+                       return err;
+               }
+
                spin_unlock(&event->vif_event_lock);
                wake_up(&event->vif_wq);
                return 0;
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.

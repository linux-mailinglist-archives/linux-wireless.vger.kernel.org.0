Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E76206FD4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgFXJQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:16:26 -0400
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com ([40.107.244.122]:17632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387914AbgFXJQZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrzIpiEEqX1Uo3l7CRiE6rwl+ILe/ATm+m5nn5WKHK720dxCGIS0BzmCRjDzkCXh7lKIT5+5ASEVCKXqYjapKA8NppGxjG+mf58vHblPLfNEUEn8y7VJVTIGEGzlPAHR86Aip6dLNXVpkRmzdxs4QDjA34oNxde/q1r5Kk8WLVBijJVAa29eRulpr5MHANkDBgm1Ke2nCrXhBbIiQePnHG2OFo4XyDLIu+w/M8YIIiTd6we7zzUlCpo0DFOF9YQKWMGgHz8Q2s8tGOPVGAjFyMlqZNx3l0eE7AZMrQVxrBfRgsegthfvD7nxs3xMn6gkBPAzsPdYY1ySoexxXZ5ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6mM4k/GqQDEtHYIR3jynmAL0J77cV7S/8g3KqEZLoY=;
 b=Yfiwbm+JQt+3naW14ceMkOBlM3PyMJtrif+NvK0+XAtdiQHPKb2SKZPuHLaMXFGxL6B9/HuG5uF6kOeT8xfKXqkdA2foaMI5yFsd6gXg+Djcss5h1A1eqdOjQhbbslG1sUsa9VVkKjjwhgMIGY5Cnx08yT4UjdAXPhjtZG63PJJJgGmaQnEYIJHeAR5dKP+SmEe8A0TLWDgykyWMOcBOy77qDq/MFfj4r/XR5bmQy4r1kRpp/Aw+29KNo8+lr0Jiqu01w+8qUXor5tX0cXEcYMNaEx4V4RlD9WETGVcDY2pJNWnHAEnaZQ0vBn0Hk2CVxb2ALCDGSFAxMOa10oGp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6mM4k/GqQDEtHYIR3jynmAL0J77cV7S/8g3KqEZLoY=;
 b=Gf2sj72MoRf3hxPMzdVo7Eu2hlnFvpzjs4svebuPrBB8a0an83etV3p+mH8Yi6COAOyuHQLYCwzZGEosEynUbwo2UvDVuJ4nXRVN18+qZstRR1LH32IIFoltPtfZtfB597gC6yhedf/wJ+7pQTmw6xFkEXt5hkWT8pJzV6RwkhQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3988.namprd06.prod.outlook.com (2603:10b6:406:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 09:16:23 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 09:16:23 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 2/2] brcmfmac: set pacing shift before transmitting skb to bus
Date:   Wed, 24 Jun 2020 04:16:08 -0500
Message-Id: <20200624091608.25154-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200624091608.25154-1-wright.feng@cypress.com>
References: <20200624091608.25154-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 09:16:22 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a074ead-bbf8-4014-c681-08d8181f436c
X-MS-TrafficTypeDiagnostic: BN7PR06MB3988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB3988F50EF129FDAF0A8C6E1EFB950@BN7PR06MB3988.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbScrL4E7N0x5rpAriObGMafA3fyjNXB2Tj8Eqm4TEWdVuJhGZWxKrLstZbwo1xMhhKOxZME4WOejfbUV4OI7jKAA556M5mqMPMoNpLVlxhpP2hxo5o7hQIqH6DU3ld5eIpclZzpbTRvxZ142yj5fO7ZoVQN5ZMKPPXsJX93Te5gh4SCA1H7jC1ov1lHNA9gic9qIllrGCZJwbi5rDSIBq0pdCzUMr+riND9SeAMwrPA4OEBOZUy1jYTL5h24V+/FWZ4qxHRsCDv0YyVNV7qnZNPLLocn2yShp+ZAkQAoQsMJ577jQpd5/3Y1a5uHFp1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(316002)(54906003)(2906002)(6666004)(66946007)(66556008)(66476007)(5660300002)(107886003)(6486002)(36756003)(478600001)(86362001)(1076003)(52116002)(7696005)(8936002)(26005)(6916009)(8676002)(186003)(16526019)(83380400001)(2616005)(956004)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: imN1GgFo/B1QNR9y+GRozY5f6HPsBjx08M+OSGpxeLit5PjgK1xRT5fUl3PjLg1J/hwTDfHrCLnwm5gQhvApyZUBe90PfP1dTUA8NrwmwVgCZNqfkyHOP7hbQ2n8B7RBkkb4mkvlMrzwHXDjwoxoLWfy1FzKRr99+p/tkO3s5en7hmYF+VCzzouRhbTRRzT8EsClKZbg2QhQ/RyFHD2EWwdRyJs87RA36K/JRQMeRgAA0+jXo4tYwQZ7sHAD+aadeX6OGgE0ExD1pwzNeX8Vqa3n2CZeGmJfS0cnxM2gG4lihmH1yVVFAtCPkkhPgoBHQSRoV+azPMO9SFQKej2DvlEYyY5MmUhfo85C4JZQHGrD0qnK8kmM4keg+4mANhFzvPCcpMiZEvm60ha1p036aIv5Xw8XNyND4uLAzhq1AAJUry1Ull4/CaikNodPI2OO7aipSRF2WszqQ2AfGwdxrUTx0380FS8JhobMSij+9evhExgSEeXyPqpk8sYFJ2+8
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a074ead-bbf8-4014-c681-08d8181f436c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 09:16:23.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq+JtP5g54EDrEdyNHHSeq3CzolSneumfK33lMnFNjEvQ4VrFnCFs6iVDmu3OuM2VFxyio4j+CCxLznMF8AWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3988
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linux 3.6 introduces TSQ which has a per socket threshold for TCP Tx
packet to reduce latency. In flow control mode, host driver enqueues skb
in hanger and TCP doesn't push new skb frees until host frees the skb when
receiving fwstatus event. So set pacing shift 8 to send them as a single
large aggregate frame to the bus layer.

43455 TX TCP throughput in different FC modes on Linux 5.4.18

sk_pacing_shift : Throughput (fcmode=0)
10: 245 Mbps
 9: 245 Mbps
 8: 246 Mbps
 7: 246 Mbps

sk_pacing_shift : Throughput (fcmode=1)
10: 182 Mbps
 9: 197 Mbps
 8: 206 Mbps
 7: 207 Mbps

sk_pacing_shift : Throughput (fcmode=2)
10: 180 Mbps
 9: 197 Mbps
 8: 206 Mbps
 7: 207 Mbps

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
v2:
 - Add more testing results

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index c88655acc78c..f89010a81ffb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -352,6 +352,9 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	if ((skb->priority == 0) || (skb->priority > 7))
 		skb->priority = cfg80211_classify8021d(skb, NULL);
 
+	/* set pacing shift for packet aggregation */
+	sk_pacing_shift_update(skb->sk, 8);
+
 	ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);
 	if (ret < 0)
 		brcmf_txfinalize(ifp, skb, false);
-- 
2.25.0


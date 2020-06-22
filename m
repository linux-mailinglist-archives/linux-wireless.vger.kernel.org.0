Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A83202E3B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 04:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFVCHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 22:07:39 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:35924
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgFVCHi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 22:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWJc+T46fhZfMrmr8tGH/584VE1R+Lfk/8lWt5tVB2U+/3+Ujoh45YzumkR029O1ca+bIvyTiAlNmF5/EZ8koRAvL6rkUKkfeTDnVo2C1lFZkrIqkTFgtP8COrzsbmUqDPM7jip9kxPBi+zrL8ANcGw4F8JsSr0ExMWV5Bt55b88iiA601rQfq0qqrvRs0iXrseRwu5StISJJOrVlkdYpvKV7l3G1cYAciqE3zRHAoD/7gzB4VFmoWI2NczJullN6My96FBP44XzpkaDXGp2YNRCpQzd4v7c6KQP598kUlK948BKkqoGOMbhO648wPwHqa6aQDb/vlf25t9oWoeeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJjbokWF2OI62h3UKRkBJF6a482pEYmw05lwWdJowP4=;
 b=cHfgeHkP3SrENB4c+oG7aQTBz7rJiAs7wlI9IQhbUAFHn8Lo1I4CK1GGOmHrAA8gKk/i1Ni2sxccDrhn1c8/ugynNLEJX5eEyVjb2tHTcEAEV/guJMyHdz8KCqwiw210V9ervMaQ6DCtVOJYcbxhE27gVbCzFjwNpxeMyo1sflWDRBMxqF/Xtka5XM0lZHP7SVcs+Ec57VqbgqHcL6yF/yCTPOmsDza3Y8ZOq+vADsYjgjeRFfLQx/oqAPf48furG9UPfhKvobBEiAdW/1K50wbUS13GdfhOMqp0xiQh1C9hi+iYY2x0NCK3u/y9HarnESYoz40uDiovOF9W+QIZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJjbokWF2OI62h3UKRkBJF6a482pEYmw05lwWdJowP4=;
 b=CVkZh7AgkLzoglYfrYjblNMYjTqH6t+6kERbAJ7bgbKuvLFGII/9zH4RN0kRtz7W6i3/VKGodBC3xlYloe2zVpkgVsLc7RqCjYwyXhzEnZ3rQenwEki8IKXOsPFyn4stM4nuD6mURUer310m9hWOMgo7I4u3E1VD47EFpy84Ykc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2370.namprd06.prod.outlook.com (2603:10b6:404:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 02:07:35 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 02:07:35 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 1/2] brcmfmac: set state of hanger slot to FREE when flushing PSQ
Date:   Sun, 21 Jun 2020 21:07:20 -0500
Message-Id: <20200622020721.498-2-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622020721.498-1-wright.feng@cypress.com>
References: <20200622020721.498-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 02:07:34 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90c02027-2951-496f-9c8f-08d8165107f7
X-MS-TrafficTypeDiagnostic: BN6PR06MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB23703F990318079C2C43FA00FB970@BN6PR06MB2370.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm+Tk3xNYfg3zFNUl6Wkff5nwG2f/RXmy9zxdeBvHdnrp9QPq9uaT+ms/imXgHQKwFEr7WEvOJGZukeeHynCKe+QbLiYDxfYVGTyOpADyEYEKYMcLFU8o2XkHcXrsc5ACS0nB8NZRLSVOYN4zCi4KDE0ulAbvctcZgvrYYcqENDSkEgf4sG3aIB/jMuRPyjjhYV22QB6immRV1tIN753ztasvIkE3l1zQCXRS0VPqkrBrI1c2lbWfl44pixAvSjg0dpBoLoL9a872odKcknLBYsdG/Q9tJJiyyBmvNbygEPRz7P/+6EJ/WFFNMvZzShm0Uu20NZMbMfWE5O++NAhgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(186003)(107886003)(36756003)(44832011)(2616005)(956004)(16526019)(6666004)(6486002)(8936002)(6916009)(478600001)(26005)(66946007)(2906002)(66556008)(54906003)(8676002)(1076003)(66476007)(5660300002)(83380400001)(316002)(86362001)(4326008)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SGr3oYyTrjaiurGNrbr6IRFCGTE5Hl7r1N+rZcw1gC008FXl/urjXFR/tdrhvE0zxwGlAqZdfYISZ+NtCTOIZpksmRwwkIrZm6KkDuPFMLgoQIS7t5AOpQkqdTOPAmNst74arvqmhAMWm9/z5xTVHeFHCGgtfEesM7xuvceNIyAgsi7J8CP1lqpzpSzaDEbhXAo8cuehs8RMGAd1VDUCVi03fctHqbUrRsc4Tpdk6OPpq/f63HI+IIbx5JZJX+fb6hpQuleQWQaackPqc1ENzU7zfGlq6ycO0mZ6l/SmdopZwPKJ9qRYbbHOB/C3bNJsSykYxQaxRbYoDAP4gHHt5MR8Fql8mWykaZI7WvCYL1FcBuHLXuFEM768HSeYHvVYR9yxyCjGkWU39qQxMte9KVzn4kXi1cTpqC2x9DU4BWWLtM5YoyITK+XdXMZUzsXVcsKVKTLL4J6oLtnLXDAquHI3lzNV1/1W/rzFtA2V4DWpW9joxikZerxoh800BWHn
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c02027-2951-496f-9c8f-08d8165107f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 02:07:35.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e68uSoQGyaLX2lX/S91Zr9+HqyLeNzieFlGi147riY2TgP78l73vJRgncZ5P2Ib/Abo9uQgnu8hPCPBdIn8h7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2370
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When USB or SDIO device got abnormal bus disconnection, host driver
tried to clean up the skbs in PSQ and TXQ (The skb's pointer in hanger
slot linked to PSQ and TSQ), so we should set the state of skb hanger slot
to BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb.
In brcmf_fws_bus_txq_cleanup it already sets
BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb, therefore we add the
same thing in brcmf_fws_psq_flush to avoid following warning message.

   [ 1580.012880] ------------   [ cut here ]------------
   [ 1580.017550] WARNING: CPU: 3 PID: 3065 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c:49
brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
   [ 1580.184017] Call Trace:
   [ 1580.186514]  brcmf_fws_cleanup+0x14e/0x190 [brcmfmac]
   [ 1580.191594]  brcmf_fws_del_interface+0x70/0x90 [brcmfmac]
   [ 1580.197029]  brcmf_proto_bcdc_del_if+0xe/0x10 [brcmfmac]
   [ 1580.202418]  brcmf_remove_interface+0x69/0x190 [brcmfmac]
   [ 1580.207888]  brcmf_detach+0x90/0xe0 [brcmfmac]
   [ 1580.212385]  brcmf_usb_disconnect+0x76/0xb0 [brcmfmac]
   [ 1580.217557]  usb_unbind_interface+0x72/0x260
   [ 1580.221857]  device_release_driver_internal+0x141/0x200
   [ 1580.227152]  device_release_driver+0x12/0x20
   [ 1580.231460]  bus_remove_device+0xfd/0x170
   [ 1580.235504]  device_del+0x1d9/0x300
   [ 1580.239041]  usb_disable_device+0x9e/0x270
   [ 1580.243160]  usb_disconnect+0x94/0x270
   [ 1580.246980]  hub_event+0x76d/0x13b0
   [ 1580.250499]  process_one_work+0x144/0x360
   [ 1580.254564]  worker_thread+0x4d/0x3c0
   [ 1580.258247]  kthread+0x109/0x140
   [ 1580.261515]  ? rescuer_thread+0x340/0x340
   [ 1580.265543]  ? kthread_park+0x60/0x60
   [ 1580.269237]  ? SyS_exit_group+0x14/0x20
   [ 1580.273118]  ret_from_fork+0x25/0x30
   [ 1580.300446] ------------   [ cut here ]------------

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 09701262330d..babaac682f13 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -621,6 +621,7 @@ static inline int brcmf_fws_hanger_poppkt(struct brcmf_fws_hanger *h,
 static void brcmf_fws_psq_flush(struct brcmf_fws_info *fws, struct pktq *q,
 				int ifidx)
 {
+	struct brcmf_fws_hanger_item *hi;
 	bool (*matchfn)(struct sk_buff *, void *) = NULL;
 	struct sk_buff *skb;
 	int prec;
@@ -632,6 +633,9 @@ static void brcmf_fws_psq_flush(struct brcmf_fws_info *fws, struct pktq *q,
 		skb = brcmu_pktq_pdeq_match(q, prec, matchfn, &ifidx);
 		while (skb) {
 			hslot = brcmf_skb_htod_tag_get_field(skb, HSLOT);
+			hi = &fws->hanger.items[hslot];
+			WARN_ON(skb != hi->pkt);
+			hi->state = BRCMF_FWS_HANGER_ITEM_STATE_FREE;
 			brcmf_fws_hanger_poppkt(&fws->hanger, hslot, &skb,
 						true);
 			brcmu_pkt_buf_free_skb(skb);
-- 
2.25.0


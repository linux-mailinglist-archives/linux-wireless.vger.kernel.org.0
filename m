Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95C206FD3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgFXJQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:16:24 -0400
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:55104
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387914AbgFXJQX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEX3S/zDovY90FX7crarVjFHKQyASXd0746gcyzDEXjyznOII8DK4Ytd1iV6fdPb9HhH0drhPNFWbTBXTcBMBA7+Ebrkm1cHRpKwYiHhC4uxpXKuvA8YA4EZwnAhTtjGQHHrtYI4OeIIc3PvpF2TpLDMVv8W6Qp5fQPiDh4koSY0dytsxzOMLkv16wBknKQKvdw1aUqxvMbJbGPXCBQltvp34CcqmnE4qtPwC8pIoW8+0oBMlnxxIDOULAIx2aE+Z+4FFdCsFwEAD/+6JSIV27DI3N923xFv9xSUkoo7SgcwnxWYqEYm5EXXd3LLsgSWHi6q5w/PuY1+Ua//rwghTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhHvb/tYupmsbcW/yGAfnuwoOUWMqBViTvlWocaM+E=;
 b=jUHV79YjzcFqcEkbETPf9mw7/kPZ6EjuyafMAoTpU58ODVCEAaLcYwivXp6a84Py4z72h4rvvW3pFwmL36pqxIQkgqucXFZSDnnKYYO6dDvEyrhkiogQ+Kg2DjB0KSb032TIVTFc3VSs8/thZtxSR508HFIFEdwK0Hmw/s/Uj5yugjV4/7cmGVmH6HQxkgUitduDv6XjhBPgezR5oiVP4e3jwr+ilyOY26ZaMu/3zYursUAVn6iNYqyuIKveH718k7lLvigWrNKSb7OdUhTisxh4yCWDE3nSTRJdFLBgnDNJDfmjatz6zZNLOxmEyCD0TZcrTJlSV/AskOkGDdc7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhHvb/tYupmsbcW/yGAfnuwoOUWMqBViTvlWocaM+E=;
 b=EBI6NyQZdMOvVHpUGZzJruLkYzibe7SAUkVjeZ9bhVwjeHTCyJXLf9Nr8Txw5iAd/idCmXpWDXum2FJBjy+pRSUX0Z+q94rHI8IjiWhfzNeKMgQ2GqMYfOn6EWIszOhZD2FRvFEn9J2cBcFhYa3sobPXN4TE2PX/VFeOnQ3FhJE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3988.namprd06.prod.outlook.com (2603:10b6:406:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 09:16:21 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 09:16:21 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 1/2] brcmfmac: set state of hanger slot to FREE when flushing PSQ
Date:   Wed, 24 Jun 2020 04:16:07 -0500
Message-Id: <20200624091608.25154-2-wright.feng@cypress.com>
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
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 09:16:19 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87af7fb2-9f26-4d94-5c51-08d8181f4213
X-MS-TrafficTypeDiagnostic: BN7PR06MB3988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB3988FC5F840D205E1FE48736FB950@BN7PR06MB3988.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNAi42Zzi9eP6HUpSTBKpSiCKDX51ux+kHMdD0xW2r3djW8WR1FaW0qTXAxslPBnfEdlXrGkSl8ifiHbhNz7xK6ZajPky8s5970mYgxhXVG9qyQ4R4bb+l2eTTq8PNGjPtPcm0NtftLynJzH11rNvkZB0R5d6EgmcyY7Y8dXNw7NpFd+ZbY4CH1Aev1zbAac+egMe2jrmzQwsHCtdmGgQxdebGT2INSRwz+WmKAbjPnEwHgp0qJXooAQfbZ8iC1qPo5y72MLmPX11rDd35lhovidZ+2tZv7GtxxFM8BOoaJ7nt+wA41QIqJgcXwWflcm42dIZgyU6dSLicrwRHrfhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(316002)(54906003)(2906002)(6666004)(66946007)(66556008)(66476007)(5660300002)(107886003)(6486002)(36756003)(478600001)(86362001)(1076003)(52116002)(7696005)(8936002)(26005)(6916009)(8676002)(186003)(16526019)(83380400001)(2616005)(956004)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /Ynwtj80qbIKiLgzrFpwQeeDelEla+nCpfB1ZA6T2MbGP79BkGpgVQHmZvlHmCQlAjVKaPmoNBWkMHGyoRH8b4Y/QTxs9dgZHoi/JvCBZNGL8/S6GlDRKZrCFtLsFY1YjDYYN+t4WvMMcstv2WQtgX6vsix3pC+mc3pAPh5FSyGZcsLsksrT51yTRdIlX4D+j7EOY7XGr+BDgUjQSoTR4Jss5CXM8FnnFchZVK2Ph6ah+bcADXvHRxp2TA/tpZdrnKDHf0C1sd7iR7P+Bobz4/OjxH6RfjsHUmeBHVOIUZdSVWSFoKi3AZSj6lPVFZcmT5omarFGU1bwn1qSEImgauYRLXjqbt3IF/FsFHjIuM7vOhvGtpJoAVuUAidYsnSelNkrimJ+o0Zyph/3WelteBYBmVKwj4LAnLNRYg+H/aW4vvC/jJ01oOQi64q3VmYtb1D3A4L1xCPLvRzepDh+EyNiHCVRnyFcXrgc6jMsSZ2Ukdpi/uyl5Zuj309lDdIH
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af7fb2-9f26-4d94-5c51-08d8181f4213
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 09:16:20.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS0Wo8N+NHDO4Dk97gbPM7AWkq+bHcVY7kNTa45keEv3iDYr90L26ePf3i6tZhzdtUuni7EQ+cjg9DglmBgitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3988
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

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
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


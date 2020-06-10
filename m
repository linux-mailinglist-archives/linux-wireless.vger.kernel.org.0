Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34E1F57A2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFJPVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:32 -0400
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:38746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729987AbgFJPVb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPLurr1KbJgmRqxMElL0ne40uChl8ZwCnyHGZT7u48gTPcgray7dgoyyOsSIqRSCM60GBf/LZQrDfbIjgW4sHioqrw0uYRTRReH97hiFbwNwywfelSk63/dbivGU+qbzckHOGGlmijg0+X4Bax3/mku3ZPo3gMFzrYHCS862KDNrrCSJyC0EknXFo31FgXWxC08A0/Cg80VxDB6Bj89rvuaSmsOEA64naTqZwVPlJltFJPirAIJfIeplv1pbyRlF2szfOu35veJzORDatGSRdO5TzcgMVSi3AEzyDL8CRoIlyMnJBMZ/UHtZvf9BwO8EMmQjRh2NshQtMu8e50nydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oTcvlhQieqo502sxUGI7vgIZdSYAA2sHcjDKoWqD0A=;
 b=npsmg4YbcmwhpB4TFUh7YfKM+tbqB/36zvw4snE+KlMh3eFsCE+ckaEnNBzHod7roEhekXHfdr1bMgZyH0e7pRpwT7uLNM6F9LxEoMMVV5FDuNl5fOXFS9N103rHYt8myg9rshBSSnOsHBaZw+g511xZZvJNO5Z8a4pUV6pvy+NT/b56OpWoPBN3YoQD3w7qvzlq6PdewTADaJtJ/8BDU6JQxomHyx2X86Rxnncl9F14T1LU7AUxIC/UbDCdLB6Yq01BapsxmxyVdC09KWX74mf+6olnZiT11G7XpCBWdM/ZxHDnb8MFQnFStZZSBi8wHi9Z6n3JjfujMn4OrmJk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oTcvlhQieqo502sxUGI7vgIZdSYAA2sHcjDKoWqD0A=;
 b=IhAyd+yrsUcfMvlTgUEgnynN9hp8ItX66QJpE39YUePpXjSBwf4g/tuAHehGIszcAux5u57oztznr+4LyzSdPqvdqvBOqp1Hf4frxUaFYjr8CCoNrTF4+yzEp7kUePMfPEeUu+2eDxUKTmvwk9HLUSynQZW0tGsSnYeXg8H3sm8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5621.namprd06.prod.outlook.com (2603:10b6:a03:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 15:21:24 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:24 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 4/6] brcmfmac: update tx status flags to sync with firmware
Date:   Wed, 10 Jun 2020 10:21:04 -0500
Message-Id: <20200610152106.175257-5-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:22 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e8201d8-02db-4eb9-a47b-08d80d51efef
X-MS-TrafficTypeDiagnostic: BYAPR06MB5621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB56219BCF908AF2CE38EFE708BB830@BYAPR06MB5621.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILGOpp6QnLYsB2sdOb8ucpfCrrSFWOJTvaKjcBkY5Lb1KJLNN56Lvl4Hv9bGFdw3bgOsGxrLU/aPa+iWUXEUUNv4qXKRDfXqTXKUcpm2b/cdds0imn8acZ0ERLPu43DIl79FAGMGjU4K3kYSFrKCHX55kmyko96f1D1a8iEdUW5HqVE8mLilLJ7PWZDxNd+ywczcy5tT4TOawIJY0ZgJkv+AcbBDtRPYJ+f5s6m6pdJhTCrPH4ZpSHcAyuhgCYmYxxmhAX7QtlGYvg9LQS5MEkrihmXbT23swsyQgaRVzuLvf40eZ4degYiBOC63ij5D2obmxwOG25QaPwNcODUpaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(16526019)(107886003)(2616005)(956004)(8936002)(26005)(1076003)(6916009)(316002)(6486002)(186003)(6666004)(2906002)(8676002)(7696005)(86362001)(66556008)(4326008)(36756003)(52116002)(54906003)(66476007)(15650500001)(5660300002)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vbSSorH5Qc4TROJncqrhIzqwz+QW5t9J+2bfrMX7xCdDb73pUxv5YL1wP+gruBcRyuR8TVtiM0a4IgJ6R7z4nSsSg12VSs218CwI1y/k06bnVS1pZaX+oavSACRnAXGnqFg485ct5m7ToaGX+z9IYnRT1/SVf11huoxJpE7TEIdwRlPa1oSsiIcncy4DB/gSe4T0YzKOMG03o+kJ/9UHyoE8TIZ7k9X0KRKTdCvBJhaNKotw+A+8vjwuepEyYL188qRBo8JZEvk+MRFP0X6y61wnVLkSpXHrJlfCHfWr5Nb/t5nkbQIAGrA+QueM2fg/bFe40oFT7iY9AWsDGx7VTov/CpTXUKBBv+JeauDL0HaF+oKssw2UWZlOV4FIgE4vOID2m7M9er90wszjGXnVXPiO7ciM2rMn95k9UmMs9cOc8ONGWeSYuPJkKvwIB1mnSu4SNZ6atFymTKq6K2yq5CP6N6PEXjbtvYo+amfKXuDZIIeO4ohRYH7pYaHMgVtY
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8201d8-02db-4eb9-a47b-08d80d51efef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:24.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJdAem5VuW1x4nyA6yQi2Q6DciEGq/MquqFCQGWvSHu8id3U9WsBfZdunxn9WTeS5Hpd/kBmd39GpJaTeniEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5621
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

There is a mismatch of tx status flag values between host and firmware.
It makes the host mistake the flags and have incorrect behavior of credit
returns. So update the flags to sync with the firmware ones.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/fwsignal.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index d7c36af4b566..ce8c6ceafc58 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -323,6 +323,10 @@ struct brcmf_skbuff_cb {
  *	firmware suppress the packet as device is already in PS mode.
  * @BRCMF_FWS_TXSTATUS_FW_TOSSED:
  *	firmware tossed the packet.
+ * @BRCMF_FWS_TXSTATUS_FW_DISCARD_NOACK:
+ *	firmware tossed the packet after retries.
+ * @BRCMF_FWS_TXSTATUS_FW_SUPPRESS_ACKED:
+ *	firmware wrongly reported suppressed previously, now fixing to acked.
  * @BRCMF_FWS_TXSTATUS_HOST_TOSSED:
  *	host tossed the packet.
  */
@@ -331,6 +335,8 @@ enum brcmf_fws_txstatus {
 	BRCMF_FWS_TXSTATUS_CORE_SUPPRESS,
 	BRCMF_FWS_TXSTATUS_FW_PS_SUPPRESS,
 	BRCMF_FWS_TXSTATUS_FW_TOSSED,
+	BRCMF_FWS_TXSTATUS_FW_DISCARD_NOACK,
+	BRCMF_FWS_TXSTATUS_FW_SUPPRESS_ACKED,
 	BRCMF_FWS_TXSTATUS_HOST_TOSSED
 };
 
@@ -1455,6 +1461,10 @@ brcmf_fws_txs_process(struct brcmf_fws_info *fws, u8 flags, u32 hslot,
 		remove_from_hanger = false;
 	} else if (flags == BRCMF_FWS_TXSTATUS_FW_TOSSED)
 		fws->stats.txs_tossed += compcnt;
+	else if (flags == BRCMF_FWS_TXSTATUS_FW_DISCARD_NOACK)
+		fws->stats.txs_discard += compcnt;
+	else if (flags == BRCMF_FWS_TXSTATUS_FW_SUPPRESS_ACKED)
+		fws->stats.txs_discard += compcnt;
 	else if (flags == BRCMF_FWS_TXSTATUS_HOST_TOSSED)
 		fws->stats.txs_host_tossed += compcnt;
 	else
-- 
2.25.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9876B1F38DD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgFIK7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:41 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgFIK7j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9KZXagqo8VPAMNGvivATSAyPtBZqPydd99iAmYzsbEgPbrq2h+VzCeZyLUmKTvwzVq2+rwt7CHWj6ez5aLYVuv1YEGG+q1KzXFTq6lpnUIkMwWQ+t5FNX2hrjvCgZxGdSBVbBdKZt8ouX4mAlTb+BG9+fA/cAJcHyagzSY8HJjItK4jYkYdWTjIsaSUqqJF9kGfDq50I78PRnjsQ6V77JOX6qMSubT0VCmV/FLmntMjuD8MRAkunvrTVDEHI/wyRhJEP5JIXeyd0R/fI1TiWFRaY/c1Su3T7s5640+hp5xyAO/1RYCbal7lIr6spnM9ejZx0HI1dQzgwvktlePq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oTcvlhQieqo502sxUGI7vgIZdSYAA2sHcjDKoWqD0A=;
 b=TfKxnKxJ4qbtGpFyGDC1e7rY9uRPkK2v0aZst7AJSF/MH3UMlFMGzXeZLd2nXbiU0QIRxywXwlaWd6B2MSYzBl+Io4efoK+ow0qB7snydrvTili0oKfEvbzymXYKUs6lcEPqSmMxCV+QqxSc9Qb6nj1no5UHe13aoOUkUaucQFvt7VCUJxJE+GHUXmv76QGVcOZo22Kk3vIamvSx4I93f1kZ/zrmuHkSSA2bypEmrZ3brR4yFMtZmd+hdLV8ocwhHmZBU9JjVWPxBjD58JQVU8kq/clrwb3Fa3UwczRREvhShjiZt7UWyTZWWHlWWDF1sSIQyaA9Q7OAkWJelHHgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oTcvlhQieqo502sxUGI7vgIZdSYAA2sHcjDKoWqD0A=;
 b=iRsovIsyJ14s9XUIDxTSEZMcNKqMCASQEuHlDx6v/v3xpEmk6dp+untn2OBZgIrNoL1JtKij1p6KAcV3ekT1U9HgC8ZbSAZxCj3ad8+hqe/SMgaMXCxcdE6Npl+YyEfGu9dhsqLoqMEfLirjl3pAt+YhmAwdIvguOQMWxQ0xWmA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:32 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:32 +0000
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
Subject: [PATCH 4/6] brcmfmac: update tx status flags to sync with firmware
Date:   Tue,  9 Jun 2020 05:59:11 -0500
Message-Id: <20200609105913.163239-5-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:30 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7532d243-0238-49e8-81bb-08d80c643030
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB50640149ADE82B7B3A9AA58CBB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4nWINNKWJ8jUvhtONUrSXMP030miRcWElj27ZVLTno1aeyusESIxkPn5/FLGqO9xsqn5D+UFUlCA8rY5imBf2E4LZMEhS+9dtJnwIuW1poMnOP2sKARuSvLk5pRroMzkLFyCvc3PIQ53KO4Bms8Jx4wHF+dpGkXqwciTgSfkM1/xxQ7tSRvq1NthMP041ycjO6hlShJTbzfNU1InakXXK1ZF/aL4rk0+oqC3iuPH85ozpJYBOD0djm9HqApL7sKQlilicNkAjtHQ6+haqJFKtQxA8DR4+KFSu3W+vk6jf6/bSOX7eczp9KBHbS1itXU1PbakHq+W5iqrIJdOGwcEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(15650500001)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IgmoSwgC8fEpFGyt3WDg8xkG0Em3Ocxt1txFRr3uooP2+RWFC5aDTGfYULFveWz1UsjxpJSgqmHRfm2svzUe686BUEJpreLNH9aV3t9FpDCIONYZb/BsT3HG5J0ULClI7e4/gFOnOYEba5ixNLV6d5y8MzdGgsa3YRPdYhT4CEQA3YVVZl3tEDNvCuGx6UvBltk41rPlB4h0wLKaLCcbGAoc6Hme0WA4d1zCxYM24WhU9TWyVw2k5Vatjify1qdzZIQKiZx3GTrW9qetwfTkH5dSalCW+SfcLeuReOcU5W+wwGzpI+9me+CXjwgux3qL+vEjFrEn8Ky00qFIgTGD6QjMXD12P0hTjfUWVwyB4Sdu9DfN7DDpBv5DSEBjaX+p7BYaR0moOadRHm23LxL67RacfcG7cXHTnucQA71jvRh+xCi+GQClcNUBf1x+ndYIdZQkYVK2dPrq+rz/ERESf4pp4ci0GaupIru9Ot8HKHbiPiW2sqiaW4MRjdMFsCkD
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7532d243-0238-49e8-81bb-08d80c643030
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:32.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tokVNd5EjcP5nXiL5bjRvGX/WLszFd3f1L46J9ihBuCgAZNHwv49Ll21kkrsNaqtRXlGyAFK6VpIG6xVvip9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
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


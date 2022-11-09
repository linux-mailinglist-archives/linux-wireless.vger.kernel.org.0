Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081E06223C5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 07:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKIGPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 01:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIGPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 01:15:24 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2081.outbound.protection.outlook.com [40.107.215.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AB315
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 22:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzQE/Ey+OM5Nb/Bykd6eV4NzPnltOvpp3PdreHd8aicMZ8q+gHOx5juGREFR36smJCQvjVvj2EUpB7dyqmGV8C326bb7QQkAuFifNh1SK/xN2FnAW0yhx7UGQ5ghzhAlKoiPOjdzCwgWXMMBBcz5njc7WUbDcpbl03+pzSQIxWBNAIZIR+K02/bLJNccBN/feYuF9czWPsVyIhvicJ0rO71yr9Zl8KpOEDojr9z3mnC4hOAYSs5NW9hXR8ZnEUnQeZ9pWaEqTfoCSIINaRNIijsnGcPJRsuI/W3UcDfkhPaIVgQo0+IDLUNGErK+l22LoVvlzZ6Hi2bybb8GozfzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pSeAI73szcTXIKxMJS5Vi9Acyg8pG2jkZcSN3/X/QM=;
 b=F/X78+gPK3x/VreSONjnQYAZ6hTQdUmvvNtLEdjUR5KB0qBlxqgKbUv0/nHyd5Gosm3t5T5kryBbiGCO2ShvuteAojjh+K8MhayOe2P3evtuxBrhP4w9H/kRjWacF9c21DVS4904aETXYt6Cph/SeevWqi9jOqt6Hx4y/TLFUpTwAFs5FrpLGxitYmbXe0flAivyjxg3ky8a3rHy5h51E7weGzNt8JP6lRntpUqbamtOFd2d8fao9CwPCWKIj+LFBcLvyO2mf107yXjG3DB8TKbeqayN1+NSU7+HF/ThrBgqxGg2TaGKBa9WYt6ZWYwR1OaC/swlwkj5rT/a2XvY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pSeAI73szcTXIKxMJS5Vi9Acyg8pG2jkZcSN3/X/QM=;
 b=mNE61q16dp/kAgXCBDo3Pa3Sc9vfgUJw+jtJo41IMGsf/0EmCKNM90X1k1IfSH1vMZFqSAmhljl3yr+22qzbHXLC6Vikn+aUH1ZeH5QguMQWgEslo0QA22UQCCsohcHOCm8G+c3r/M/m4llZfx8/Y/YwKeNCsDdG1XeMZ3CHLl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by TY0PR0101MB4190.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:14 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 06:15:14 +0000
Date:   Wed, 9 Nov 2022 15:15:32 +0900
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: Classification of BSS with different frequencies in KHz
Message-ID: <20221109061532.GA13554@DESKTOP-7BCE18E.localdomain>
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|TY0PR0101MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d69be1-354d-4443-1d23-08dac219c3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElcXnZCgzhcsm6olZv8tTFInW3e1Sqfy6r9U4r8N/xsAwSjdxBuezACG/wqmjgPsEf9bMKIUP+km1tKJOPfgAoKLsXerciSefHF/kYWHw/hMSQLVRQ3LOnJDWJvzgDNrYC7qE1Cj9jBSjt3cUQ8jB9EcKA5tyimZmqeZrKNLmRo15P5Epl5Kvvd/ZTwAlgg+aIYxNruBGvga2gtf2X/mqIMAKkp3XzTJI9bOhYKPnNfdQLO5SCN19WoEDKN8yJaJki3Vk6weIfuJ5wErIJUSscxUkZu7i1cOC4XPoZ6x0P/v6klR4bh2NQS2uYR1IOzmNrybPhGpaAInSZbcMCsuA4czWiSIC2hV9zfZoGXgpQxo/YMbJQNRSN6uKbCX0vSmv5sEEmi8y9/b6+G0IonPCJGIZ1kEaYvnzMXTPn4EggyQO8gO4xJTJtW0WHEAC1E7UWG9ARZDBxMZ0Q2JwlrTKcHUS6WvTXz78BkkJe00EzQGjWhU5ZhgOtBxaL0POJ6XpNnnjdS+old9DWOxigRNzCTYEDFozzVHifM2TTBG5FJv3NdKduM7UfgQs3/IVtvOlA80nsDn/ZiPc/jkvlvgayYWoDwFIwq4I9iY7/ebk0Wvkb0kEIfpsMfNwpOF9gLssoU/l3LGHbR4uTpPuwNrIFh9Cn7+SbDi9exGlhZhhclQEnQUVirCHrmusQ7Ngyah3qYqpB5tNNIvRfwjBoIa9ZvSftioI/4Ue+ZM6nOY52yiVMSNV+hOc83d5Lr8XWxzVN9D+MKn/V3y+M9RpQOWH5FlURz9Qn2UCmyL9D7J/kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39840400004)(376002)(396003)(451199015)(564344004)(33656002)(38350700002)(478600001)(38100700002)(86362001)(8936002)(6512007)(2906002)(9686003)(26005)(1076003)(6506007)(52116002)(44144004)(6916009)(6486002)(6666004)(5660300002)(235185007)(186003)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8676002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xc2T6KqwiCZs+x1fHfENGEkGQgb/k2T4aJkGchN9Fbg3U3UMrN5Ln268Pwi9?=
 =?us-ascii?Q?4UntqWSFFFNuHe7EdQ0dKDNugWHSTUxEWAhO2plUGweQvYH8wY+Wt7UGtlSx?=
 =?us-ascii?Q?b4X1ybWmAM1FhWWibckBG+a20hvX4DvRFortEsE3kKqBsNbG6cIO0c9Jan4d?=
 =?us-ascii?Q?6KODs4Bi1aetE0W7C0W+ziDQF6e2oN7aeSGh0eNjIGRpKsGNm2BOhkyTfERp?=
 =?us-ascii?Q?vOfunXqybjMf0HjSO7iAEc4qoCDEjMSXzApNSPoxT7CDyFx3lQOAfJKJM8u3?=
 =?us-ascii?Q?llC01q82JMbJrbtqzNNIAAGMiAeaauh59kKCqw9Y75GykHRWKCjqdDh99JCB?=
 =?us-ascii?Q?9d53YHkk4N/mt1VL4mEuXI9/vHrYfCJLEtsT6MU0EVfanN+C9eTkbcsOjN+h?=
 =?us-ascii?Q?iZavb+1Nleci4SmQt5tn0WvcR6//IvCNyHBU3eE8hFZfvTYhmKEyLYMWKrzU?=
 =?us-ascii?Q?U103mdSNTIDyvRW6VGHYGdRfkpTXPgB4R4VT8j5+8DY9WqNGMC0sUYJuguTX?=
 =?us-ascii?Q?NsZpOhZ4nYwgYjlNjnilbNZ39tHA7ITTzPiKdrSXEWzjtZNx0I+bilR4fnxX?=
 =?us-ascii?Q?Z83rShuBMndjvcEhqXt4PK8dmkpm6B7FqWG8+0OaHRE/qIOH1NWHDLiqolFf?=
 =?us-ascii?Q?DfRTcDD8jQ3BT7cz3ws/Bq9uTbENvyZqfATDWXITT8v+wBjR4zURyaqmWNCH?=
 =?us-ascii?Q?91SfCqpy7C95KNJf0kHlkddIFhyC8bDSHQ1hp23415zQTTcxWv0FSbozlbbv?=
 =?us-ascii?Q?y4XhTwjUu2hbJXzADXb5ibBlM7qQu5muCT129Cb/jQMn/AGnJCTvYj9aAlQJ?=
 =?us-ascii?Q?hWOXitu5zs1q+QuaDP3nvYKUQOBEKqHuA4Q/t4RXhtuQu7W0MytKbyv396Ob?=
 =?us-ascii?Q?XRuKIsHYGbFJYaw2NE6Ww0bf8sE5wSJBZiGp59Rqp78ImGmHq3co0DnQo/qJ?=
 =?us-ascii?Q?5Fdlw1pgRKO5XBPW34m7smJ95ZD+m3+hdUq7yfmntXAUkM1plLZdAFQA5TWa?=
 =?us-ascii?Q?6K0RBOrMgyBFAKM/GqJh6WDWf/m+0xxUrI5oHbsnWX4vAUMZF4SVdwNakh/Y?=
 =?us-ascii?Q?+clraTw8PB6SagI4VKhmMvBa6vBu0/i/rreJVAwG9eEmgYNXXGQafP2JbbYZ?=
 =?us-ascii?Q?8WyoExYjX6cWSKbYYXhBN0lw6zG8n74WQP2mOIsAYg2uNHM4DkT/8Ti+27jX?=
 =?us-ascii?Q?dlG2MG23YMQ1dGQZmqlsuBb7eTYoGdZC4+kFX2jJtU3Firr9U0xZY8slIVGo?=
 =?us-ascii?Q?FI2dvBp40u+C8bzlws0SLvEtCHQ2RR5/Pcq8MUVbyYeyf74uO6JeASLLzuZI?=
 =?us-ascii?Q?Xj1gsi01sOdNyui+CzxSJVBKo94uhtllGpNRACZ8dXQaPFnTZFa29FFZcru9?=
 =?us-ascii?Q?EN1mAljWh2M2esFTbln/vCMlP61LjC2scUJSI0riwEUMds9atks2PKGzACMb?=
 =?us-ascii?Q?PWhywAK8uliQn83+c9f9WfnQGi1cIOYGUB7u6k/8tbogbN6qdL0daq31D1xT?=
 =?us-ascii?Q?S7j1oLe6TSMbcq5u3HymodprafkbJO2r570ypliA4at3mFpqC6qqBzueqUBF?=
 =?us-ascii?Q?noFeBeLf9GZeXgEVklP458hR0HcNEgqnavNo+8Ql?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d69be1-354d-4443-1d23-08dac219c3f7
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:14.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRktiJitARq1alijL4bVLfZiFHKPSkZK8T4BOzLFST+3EueUz50TyXW79c1mf5/6AtNYYHnV9la2iaO5zYyePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

"freq_offset" also needs to be compared on S1G Band.
If freq_offset comparison is omitted in cmp_bss, other bss cannot be distinguished in units of khz.

--LQksG6bCIzRHxTLp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Classification-of-BSS-with-different-frequencies-in-.patch"

From 39e6b6b9ecf0b301223dd9e34715e9d103573ff7 Mon Sep 17 00:00:00 2001
From: JUN-KYU SHIN <jk.shin@newratek.com>
Date: Wed, 9 Nov 2022 14:35:49 +0900
Subject: [PATCH] Classification of BSS with different frequencies in KHz.

"freq_offset" also needs to be compared on S1G Band.
If freq_offset comparison is omitted in cmp_bss,
other bss cannot be distinguished in units of khz.

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 806a5f1330ff..3cfc668c4189 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1289,7 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
 	int i, r;
 
 	if (a->channel != b->channel)
-		return b->channel->center_freq - a->channel->center_freq;
+		return ((b->channel->center_freq + b->channel->freq_offset) -
+					(a->channel->center_freq + a->channel->freq_offset));
 
 	a_ies = rcu_access_pointer(a->ies);
 	if (!a_ies)
-- 
2.25.1


--LQksG6bCIzRHxTLp--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055A740FBD6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbhIQPSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 11:18:17 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:4192
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244297AbhIQPRK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 11:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfXjXl7iJUq8JY8AJ56AzaEWvmucdnubtYFJi2R9ak8tEaH6+QtfmGqlz6C+dSvf7gPJvfj2zA/p7qIHwJnmQTVWcaj4Oef/6iLEZXTqJy7OMj6XzGs2O7YjnrIDAnIEvZELEp+zSF78zmHav5670RjpYaBQMpGupyIydZvg5BlLRnDC3eTcIlgOQpZQzaZZgPwR5B2c39p6gRpXzcbfFLiS2246bKTIsIAhM7YemQm+FrAHeCyXqKa1t5l39CF1WeHqFskny1PvNjYPTbJCqRYSvOduh18u7QV1GBrAfpWCM6NIk3X95DKyyiDobYqi3Yp81LFI8yGtvikA6pc2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6GL47d7QkI6cbgNydxd8mw6pRJ/9458hhnCA+qRmPKc=;
 b=nMNLsbZLa/B1xV1t3GYr/PLFo4nGmq95rtrI+/bJpFL+CKKNiM9uMn5DrM5l3sByvERZUna6eZ8yz1kb6SJigpfQ3ka3cBYEqLqWpbWR9gvkholf0n61e5F8vVLUYaS88UPSR3YLK3tZewXjFnZayFcfP3tvMoa7rmSTVElQPuxfm7qjvJcf7vvItWolH1rAIgkkndV+InRCSbts/R1tdTziY4IEExwMI3xoqsioGvyB0o1ZhdDeGMhURrM0GOo+tCivoHYPt+9+Jpu73NgD0QCzQRu3wMHXcXK1+RTiskl7N/2gEzmA/0gcbZ2ywEt+fBB33iSqQfUo7+Mu9KedDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GL47d7QkI6cbgNydxd8mw6pRJ/9458hhnCA+qRmPKc=;
 b=eIUXokDPnEbRqIDhMYkCvePa6crTAxUthzVlyoj/DT19d6CH5QMU0VSVSDYBjZXFTSizdDrmikeDGGUuWDOBaP/g0qbhVVzcrZoOyQmbXonYiftKXgOjnO0ATJ3eqgkqVyWBS0UgOjVwuV6XbRgmoP0zl5vycT/NJkQCaxR6sv0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 15:15:02 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Fri, 17 Sep 2021
 15:15:02 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v6 17/24] wfx: add queue.c/queue.h
Date:   Fri, 17 Sep 2021 17:13:53 +0200
Message-Id: <20210917151401.2274772-18-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
References: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 15:14:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8dc68f-4342-4329-a245-08d979edeb9e
X-MS-TrafficTypeDiagnostic: SA2PR11MB4876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB487646362898FE52D1115F5E93DD9@SA2PR11MB4876.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UasLHqwadOIWnFAnUMEuzFeejM4KkPbLD5AAMuQuNTuGruEyoI/Gc/SbioY/Jt99538M1AA2vuIF+oHA/Al3DyYMyOt3lE0IJ4+WiJvi6oQBh3Lb20DZiqVJoAqrnhu+XHCipbtZQQGq1SfsEojgTkgXBZMUCwVBu5cAcRHpUkR/kg5jfQQWDrtnC428u85BLbAdfR0E1HOmDyDaU1zOo6esp08lcHw20Q9eh8LMpCwaiZIEO0mNpNlmHij0nQ6S5XNkzg6KSDdjJ1mWXcenDBt8XbDY9y1DuqYZPdamlU45R/vJgLHnR3paWMWZjOBxD8Fult98YgXBh0COlHcHRpw6zr13Vb1Zn5Ok46+Q1N6nKi4FhNC/5C2zJT+Fo87oxv6avwYa5iUuX4VQXyxCSsoXFNiyQAzs03bF9t2hHuDnkMAWOju3FLIc6IJIYHJko/z6qkTtkteiza9q2EFydaUf3OjsDFiEy9Fkn3ho6UittOJNoOk4IF/dBkwTe7a/UefjiwW8EeMDap0sNrPakOuGTxPWsIrix4S7nMpt2wJj0AzQohCu26edFg4Y12PEhIkSxFvOZESMwnyUC89/CDtIVTJft8XD5FBEuoGVm57PCdHcq/BIx1SKM44FJTeqAJ3YTmJlQMXcR883+xOAPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(1076003)(6486002)(38100700002)(107886003)(66574015)(36756003)(8936002)(2906002)(7416002)(54906003)(5660300002)(186003)(8676002)(508600001)(52116002)(7696005)(6916009)(66476007)(66946007)(66556008)(2616005)(86362001)(316002)(4326008)(30864003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1pNZm1QUksrRVY4U2hsaUZubllCWE1NT2FCTjNLeW5kSmNaaGxpZHc3NURK?=
 =?utf-8?B?TGVXYzhZcEtnNEJRVHVSdmovbFF3bWtIQ1EwYm1Fc3p4L2dNWUhSTUhqUEM5?=
 =?utf-8?B?Z3hNdWRlQi9CLzJ4aldOeVByQlhWdVBlVSsyb1ZxbFhnQjZRaUVCVUcydjF3?=
 =?utf-8?B?Z1VETnBhWFFWUEdvZFVISURKbU5hUVdyS205WUNTMVo3ZGlvVWhPVEgyY1BY?=
 =?utf-8?B?aUhwSFVIMVBxWWx4ZFRmMUtTaVc4TFhCVnF5WXJweWplVFlheVE4WUpOM0x3?=
 =?utf-8?B?L2pvMmgwczY3NVpEN0xjSnVmekJITUtOUDZldEJIU0MzS2JPQnhBSlBMUnR6?=
 =?utf-8?B?L2hoSEczMWc0eHVHejhLNXhhNEtnbHF2VEl3TERUU09ra2Z0YzNLWGN3eWl0?=
 =?utf-8?B?RkduWklQUW5JeDZUamRxTllOVVhlN0lDem5YVnlVdXF5TFY3cWlUZVN1Q0hl?=
 =?utf-8?B?anFIb0t3eVIzbVduY1VYYXRJbVh2eDJoR0ZCYUpabEFRbkc1eE1WUzFleXZI?=
 =?utf-8?B?TzdVM09tdHFNQ2xPZDhOdUdBRzNRZndMMlVxU3ZMVXU0U3ZUazlXd2ZKU1Nk?=
 =?utf-8?B?QXpQWGl0azlnVmNKdm4xY2kzVGo4eEhpdHlsVUtHTFpFeUJVTGR6UmZPelJI?=
 =?utf-8?B?RGR2UjZJUVBPTElJK2QvZk5sL1lGTlM1VlpGLy9XZXpIZ2Zwd0FBNmpJN1FV?=
 =?utf-8?B?QjRzYUZiZXVheXVSRDZTWmVOVTZuWk53bUxnVjFzL2tXQmRKcGRocWx5dFZH?=
 =?utf-8?B?d3M0L1BlcHRqcUFhVVRIc2dPdzdCZGpDMEtUMHZGdjh5OHVubUdwR3ZMQ0Zx?=
 =?utf-8?B?SnQvNkpMajBPc1V0MjNlaWk2OG5CdEx6VS9ablliSnBGZWlKT3grOXY0OG1O?=
 =?utf-8?B?ak5JZW14K2lBbXZMSjZ6d1lkeks5S2F5Z1BvNEdxNnZUN3BCblZyUVZ6N1VZ?=
 =?utf-8?B?azYwd1o3OEZwWllXTHJmMEFscXM1YmpPWklIdkc0ZXhiajM3Wnc3MENHaWFQ?=
 =?utf-8?B?Y0UvMnh6dzlJSnVjTDBhcnN1NW5hM1UzbHJWM1R3eHNRdDJCc0pyOUJHUUtC?=
 =?utf-8?B?Wk91S2p3Z2k4RHpCSVlzcVIycmdkVHRtM3ZnTUFmcW5uWlU1Sm84ZjkyaThq?=
 =?utf-8?B?R1JsOEhscEdET2hGWDczeHM1aEhSckpkdjN1bjA1NjFjcUJoZk1YTlRWVHZj?=
 =?utf-8?B?cUs4SjZuRWFFZHRkUlFGeTg3cmwrRDZ5c2JXWmNVZ29pU2JSWXZYb2wyUUVu?=
 =?utf-8?B?UU1IaWNvc0ZzekJYekRoTk1odmRwTEZjdG1kNUVUVnA5YXRvREEwMTZ6NDQ2?=
 =?utf-8?B?ZG43Um5QTlk4Skt3ZmpQMDJpZXVtZUZBZlJNS3NyRFd2bXRzUkk0UE9ISmho?=
 =?utf-8?B?dXdkSFV0RkZjSnVsQWpHSjErK0Mzci9Ncmw2UHhzYU9GaFhEeXJ2TGVMR3N4?=
 =?utf-8?B?dTlNTmRBOExRMlZXYlRiZitOMEg2RDB4SUpBa0toRmRUWEFCeDRjNm5YVlRO?=
 =?utf-8?B?eU5XV2VyR2ZwSXFkd2ZKL3lwY2pDTnM5M09leFN0YlZBNm04eTN1cGdQZVdC?=
 =?utf-8?B?NkJ0RjU3SHNFTjB3U3IyMFk3cXBnSWRmL0FQalVwZGt6NFVyMEoxeUhwQXE3?=
 =?utf-8?B?T2I3SkdpeStyZWttYVU1RFE0NkhoREEzZHp6TVZZdWRLdFE1dG5kbmlUclhT?=
 =?utf-8?B?bkdZV3JzNGxseG91YUlQU0NWblR1bzRrdkE4dlJjN0VUczVqZENJMWFWK3B6?=
 =?utf-8?B?R1Q0UGkweUhDcFhaVGFtWUdJeUp0K0hKUDg4WlA5NmE0ZjJmcHhTUDM2aVJs?=
 =?utf-8?B?elFqSmRuQm10RHlVdHJuNWVqeFQ5N2ZIb3NpcG95dW5pWnBrWC9DSEFZWjBm?=
 =?utf-8?Q?O6tTmB8kZPstB?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8dc68f-4342-4329-a245-08d979edeb9e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:15:01.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOwySWQVg2uOX22XnGxPAiCnGlavSRAeYzlYF1YTBugPVtK058DPfwYqoNWTaHKpc51qw/xrgVUecfD/xMnZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuYyB8IDMwNyArKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVl
dWUuaCB8ICA0NSArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM1MiBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5o
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uN2EzYmEzYzM4OTI1Ci0tLSAvZGV2L251bGwKKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCkBAIC0wLDAgKzEsMzA3IEBA
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgorICogUXVldWUg
YmV0d2VlbiB0aGUgdHggb3BlcmF0aW9uIGFuZCB0aGUgYmggd29ya3F1ZXVlLgorICoKKyAqIENv
cHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29w
eXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICovCisjaW5jbHVkZSA8bGludXgvc2NoZWQu
aD4KKyNpbmNsdWRlIDxuZXQvbWFjODAyMTEuaD4KKworI2luY2x1ZGUgInF1ZXVlLmgiCisjaW5j
bHVkZSAid2Z4LmgiCisjaW5jbHVkZSAic3RhLmgiCisjaW5jbHVkZSAiZGF0YV90eC5oIgorI2lu
Y2x1ZGUgInRyYWNlcy5oIgorCit2b2lkIHdmeF90eF9sb2NrKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
KQoreworCWF0b21pY19pbmMoJndkZXYtPnR4X2xvY2spOworfQorCit2b2lkIHdmeF90eF91bmxv
Y2soc3RydWN0IHdmeF9kZXYgKndkZXYpCit7CisJaW50IHR4X2xvY2sgPSBhdG9taWNfZGVjX3Jl
dHVybigmd2Rldi0+dHhfbG9jayk7CisKKwlXQVJOKHR4X2xvY2sgPCAwLCAiaW5jb25zaXN0ZW50
IHR4X2xvY2sgdmFsdWUiKTsKKwlpZiAoIXR4X2xvY2spCisJCXdmeF9iaF9yZXF1ZXN0X3R4KHdk
ZXYpOworfQorCit2b2lkIHdmeF90eF9mbHVzaChzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwlp
bnQgcmV0OworCisJLyogRG8gbm90IHdhaXQgZm9yIGFueSByZXBseSBpZiBjaGlwIGlzIGZyb3pl
biAqLworCWlmICh3ZGV2LT5jaGlwX2Zyb3plbikKKwkJcmV0dXJuOworCisJd2Z4X3R4X2xvY2so
d2Rldik7CisJbXV0ZXhfbG9jaygmd2Rldi0+aGlmX2NtZC5sb2NrKTsKKwlyZXQgPSB3YWl0X2V2
ZW50X3RpbWVvdXQod2Rldi0+aGlmLnR4X2J1ZmZlcnNfZW1wdHksCisJCQkJICF3ZGV2LT5oaWYu
dHhfYnVmZmVyc191c2VkLAorCQkJCSBtc2Vjc190b19qaWZmaWVzKDMwMDApKTsKKwlpZiAoIXJl
dCkgeworCQlkZXZfd2Fybih3ZGV2LT5kZXYsICJjYW5ub3QgZmx1c2ggdHggYnVmZmVycyAoJWQg
c3RpbGwgYnVzeSlcbiIsCisJCQkgd2Rldi0+aGlmLnR4X2J1ZmZlcnNfdXNlZCk7CisJCXdmeF9w
ZW5kaW5nX2R1bXBfb2xkX2ZyYW1lcyh3ZGV2LCAzMDAwKTsKKwkJLyogRklYTUU6IGRyb3AgcGVu
ZGluZyBmcmFtZXMgaGVyZSAqLworCQl3ZGV2LT5jaGlwX2Zyb3plbiA9IHRydWU7CisJfQorCW11
dGV4X3VubG9jaygmd2Rldi0+aGlmX2NtZC5sb2NrKTsKKwl3ZnhfdHhfdW5sb2NrKHdkZXYpOwor
fQorCit2b2lkIHdmeF90eF9sb2NrX2ZsdXNoKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCXdm
eF90eF9sb2NrKHdkZXYpOworCXdmeF90eF9mbHVzaCh3ZGV2KTsKK30KKwordm9pZCB3ZnhfdHhf
cXVldWVzX2luaXQoc3RydWN0IHdmeF92aWYgKnd2aWYpCit7CisJLyogVGhlIGRldmljZSBpcyBp
biBjaGFyZ2UgdG8gcmVzcGVjdCB0aGUgZGV0YWlscyBvZiB0aGUgUW9TIHBhcmFtZXRlcnMuCisJ
ICogVGhlIGRyaXZlciBqdXN0IGVuc3VyZSB0aGF0IGl0IHJvdWdodGx5IHJlc3BlY3QgdGhlIHBy
aW9yaXRpZXMgdG8KKwkgKiBhdm9pZCBhbnkgc2hvcnRhZ2UuCisJICovCisJY29uc3QgaW50IHBy
aW9yaXRpZXNbSUVFRTgwMjExX05VTV9BQ1NdID0geyAxLCAyLCA2NCwgMTI4IH07CisJaW50IGk7
CisKKwlmb3IgKGkgPSAwOyBpIDwgSUVFRTgwMjExX05VTV9BQ1M7ICsraSkgeworCQlza2JfcXVl
dWVfaGVhZF9pbml0KCZ3dmlmLT50eF9xdWV1ZVtpXS5ub3JtYWwpOworCQlza2JfcXVldWVfaGVh
ZF9pbml0KCZ3dmlmLT50eF9xdWV1ZVtpXS5jYWIpOworCQl3dmlmLT50eF9xdWV1ZVtpXS5wcmlv
cml0eSA9IHByaW9yaXRpZXNbaV07CisJfQorfQorCitib29sIHdmeF90eF9xdWV1ZV9lbXB0eShz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0IHdmeF9xdWV1ZSAqcXVldWUpCit7CisJcmV0dXJu
IHNrYl9xdWV1ZV9lbXB0eV9sb2NrbGVzcygmcXVldWUtPm5vcm1hbCkgJiYKKwkgICAgICAgc2ti
X3F1ZXVlX2VtcHR5X2xvY2tsZXNzKCZxdWV1ZS0+Y2FiKTsKK30KKwordm9pZCB3ZnhfdHhfcXVl
dWVzX2NoZWNrX2VtcHR5KHN0cnVjdCB3ZnhfdmlmICp3dmlmKQoreworCWludCBpOworCisJZm9y
IChpID0gMDsgaSA8IElFRUU4MDIxMV9OVU1fQUNTOyArK2kpIHsKKwkJV0FSTl9PTihhdG9taWNf
cmVhZCgmd3ZpZi0+dHhfcXVldWVbaV0ucGVuZGluZ19mcmFtZXMpKTsKKwkJV0FSTl9PTighd2Z4
X3R4X3F1ZXVlX2VtcHR5KHd2aWYsICZ3dmlmLT50eF9xdWV1ZVtpXSkpOworCX0KK30KKworc3Rh
dGljIHZvaWQgX193ZnhfdHhfcXVldWVfZHJvcChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwKKwkJCQlz
dHJ1Y3Qgc2tfYnVmZl9oZWFkICpza2JfcXVldWUsCisJCQkJc3RydWN0IHNrX2J1ZmZfaGVhZCAq
ZHJvcHBlZCkKK3sKKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCAqdG1wOworCisJc3Bpbl9sb2NrX2Jo
KCZza2JfcXVldWUtPmxvY2spOworCXNrYl9xdWV1ZV93YWxrX3NhZmUoc2tiX3F1ZXVlLCBza2Is
IHRtcCkgeworCQlfX3NrYl91bmxpbmsoc2tiLCBza2JfcXVldWUpOworCQlza2JfcXVldWVfaGVh
ZChkcm9wcGVkLCBza2IpOworCX0KKwlzcGluX3VubG9ja19iaCgmc2tiX3F1ZXVlLT5sb2NrKTsK
K30KKwordm9pZCB3ZnhfdHhfcXVldWVfZHJvcChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0
IHdmeF9xdWV1ZSAqcXVldWUsCisJCSAgICAgICBzdHJ1Y3Qgc2tfYnVmZl9oZWFkICpkcm9wcGVk
KQoreworCV9fd2Z4X3R4X3F1ZXVlX2Ryb3Aod3ZpZiwgJnF1ZXVlLT5jYWIsIGRyb3BwZWQpOwor
CV9fd2Z4X3R4X3F1ZXVlX2Ryb3Aod3ZpZiwgJnF1ZXVlLT5ub3JtYWwsIGRyb3BwZWQpOworCXdh
a2VfdXAoJnd2aWYtPndkZXYtPnR4X2RlcXVldWUpOworfQorCit2b2lkIHdmeF90eF9xdWV1ZXNf
cHV0KHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCXN0cnVj
dCB3ZnhfcXVldWUgKnF1ZXVlID0gJnd2aWYtPnR4X3F1ZXVlW3NrYl9nZXRfcXVldWVfbWFwcGlu
Zyhza2IpXTsKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm8gPSBJRUVFODAyMTFf
U0tCX0NCKHNrYik7CisKKwlpZiAodHhfaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX1NF
TkRfQUZURVJfRFRJTSkKKwkJc2tiX3F1ZXVlX3RhaWwoJnF1ZXVlLT5jYWIsIHNrYik7CisJZWxz
ZQorCQlza2JfcXVldWVfdGFpbCgmcXVldWUtPm5vcm1hbCwgc2tiKTsKK30KKwordm9pZCB3Znhf
cGVuZGluZ19kcm9wKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZl9oZWFkICpk
cm9wcGVkKQoreworCXN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlOworCXN0cnVjdCB3ZnhfdmlmICp3
dmlmOworCXN0cnVjdCBoaWZfbXNnICpoaWY7CisJc3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCVdB
Uk4oIXdkZXYtPmNoaXBfZnJvemVuLCAiJXMgc2hvdWxkIG9ubHkgYmUgdXNlZCB0byByZWNvdmVy
IGEgZnJvemVuIGRldmljZSIsCisJICAgICBfX2Z1bmNfXyk7CisJd2hpbGUgKChza2IgPSBza2Jf
ZGVxdWV1ZSgmd2Rldi0+dHhfcGVuZGluZykpICE9IE5VTEwpIHsKKwkJaGlmID0gKHN0cnVjdCBo
aWZfbXNnICopc2tiLT5kYXRhOworCQl3dmlmID0gd2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50
ZXJmYWNlKTsKKwkJaWYgKHd2aWYpIHsKKwkJCXF1ZXVlID0gJnd2aWYtPnR4X3F1ZXVlW3NrYl9n
ZXRfcXVldWVfbWFwcGluZyhza2IpXTsKKwkJCVdBUk5fT04oc2tiX2dldF9xdWV1ZV9tYXBwaW5n
KHNrYikgPiAzKTsKKwkJCVdBUk5fT04oIWF0b21pY19yZWFkKCZxdWV1ZS0+cGVuZGluZ19mcmFt
ZXMpKTsKKwkJCWF0b21pY19kZWMoJnF1ZXVlLT5wZW5kaW5nX2ZyYW1lcyk7CisJCX0KKwkJc2ti
X3F1ZXVlX2hlYWQoZHJvcHBlZCwgc2tiKTsKKwl9Cit9CisKK3N0cnVjdCBza19idWZmICp3Znhf
cGVuZGluZ19nZXQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBwYWNrZXRfaWQpCit7CisJc3Ry
dWN0IHdmeF9xdWV1ZSAqcXVldWU7CisJc3RydWN0IGhpZl9yZXFfdHggKnJlcTsKKwlzdHJ1Y3Qg
d2Z4X3ZpZiAqd3ZpZjsKKwlzdHJ1Y3QgaGlmX21zZyAqaGlmOworCXN0cnVjdCBza19idWZmICpz
a2I7CisKKwlzcGluX2xvY2tfYmgoJndkZXYtPnR4X3BlbmRpbmcubG9jayk7CisJc2tiX3F1ZXVl
X3dhbGsoJndkZXYtPnR4X3BlbmRpbmcsIHNrYikgeworCQloaWYgPSAoc3RydWN0IGhpZl9tc2cg
Kilza2ItPmRhdGE7CisJCXJlcSA9IChzdHJ1Y3QgaGlmX3JlcV90eCAqKWhpZi0+Ym9keTsKKwkJ
aWYgKHJlcS0+cGFja2V0X2lkICE9IHBhY2tldF9pZCkKKwkJCWNvbnRpbnVlOworCQlzcGluX3Vu
bG9ja19iaCgmd2Rldi0+dHhfcGVuZGluZy5sb2NrKTsKKwkJd3ZpZiA9IHdkZXZfdG9fd3ZpZih3
ZGV2LCBoaWYtPmludGVyZmFjZSk7CisJCWlmICh3dmlmKSB7CisJCQlxdWV1ZSA9ICZ3dmlmLT50
eF9xdWV1ZVtza2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKV07CisJCQlXQVJOX09OKHNrYl9nZXRf
cXVldWVfbWFwcGluZyhza2IpID4gMyk7CisJCQlXQVJOX09OKCFhdG9taWNfcmVhZCgmcXVldWUt
PnBlbmRpbmdfZnJhbWVzKSk7CisJCQlhdG9taWNfZGVjKCZxdWV1ZS0+cGVuZGluZ19mcmFtZXMp
OworCQl9CisJCXNrYl91bmxpbmsoc2tiLCAmd2Rldi0+dHhfcGVuZGluZyk7CisJCXJldHVybiBz
a2I7CisJfQorCXNwaW5fdW5sb2NrX2JoKCZ3ZGV2LT50eF9wZW5kaW5nLmxvY2spOworCVdBUk4o
MSwgImNhbm5vdCBmaW5kIHBhY2tldCBpbiBwZW5kaW5nIHF1ZXVlIik7CisJcmV0dXJuIE5VTEw7
Cit9CisKK3ZvaWQgd2Z4X3BlbmRpbmdfZHVtcF9vbGRfZnJhbWVzKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2LCB1bnNpZ25lZCBpbnQgbGltaXRfbXMpCit7CisJa3RpbWVfdCBub3cgPSBrdGltZV9nZXQo
KTsKKwlzdHJ1Y3Qgd2Z4X3R4X3ByaXYgKnR4X3ByaXY7CisJc3RydWN0IGhpZl9yZXFfdHggKnJl
cTsKKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOworCWJvb2wgZmlyc3QgPSB0cnVlOworCisJc3Bpbl9s
b2NrX2JoKCZ3ZGV2LT50eF9wZW5kaW5nLmxvY2spOworCXNrYl9xdWV1ZV93YWxrKCZ3ZGV2LT50
eF9wZW5kaW5nLCBza2IpIHsKKwkJdHhfcHJpdiA9IHdmeF9za2JfdHhfcHJpdihza2IpOworCQly
ZXEgPSB3Znhfc2tiX3R4cmVxKHNrYik7CisJCWlmIChrdGltZV9hZnRlcihub3csIGt0aW1lX2Fk
ZF9tcyh0eF9wcml2LT54bWl0X3RpbWVzdGFtcCwKKwkJCQkJCSAgbGltaXRfbXMpKSkgeworCQkJ
aWYgKGZpcnN0KSB7CisJCQkJZGV2X2luZm8od2Rldi0+ZGV2LCAiZnJhbWVzIHN0dWNrIGluIGZp
cm13YXJlIHNpbmNlICVkbXMgb3IgbW9yZTpcbiIsCisJCQkJCSBsaW1pdF9tcyk7CisJCQkJZmly
c3QgPSBmYWxzZTsKKwkJCX0KKwkJCWRldl9pbmZvKHdkZXYtPmRldiwgIiAgIGlkICUwOHggc2Vu
dCAlbGxkbXMgYWdvXG4iLAorCQkJCSByZXEtPnBhY2tldF9pZCwKKwkJCQkga3RpbWVfbXNfZGVs
dGEobm93LCB0eF9wcml2LT54bWl0X3RpbWVzdGFtcCkpOworCQl9CisJfQorCXNwaW5fdW5sb2Nr
X2JoKCZ3ZGV2LT50eF9wZW5kaW5nLmxvY2spOworfQorCit1bnNpZ25lZCBpbnQgd2Z4X3BlbmRp
bmdfZ2V0X3BrdF91c19kZWxheShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwKKwkJCQkJICBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiKQoreworCWt0aW1lX3Qgbm93ID0ga3RpbWVfZ2V0KCk7CisJc3RydWN0IHdm
eF90eF9wcml2ICp0eF9wcml2ID0gd2Z4X3NrYl90eF9wcml2KHNrYik7CisKKwlyZXR1cm4ga3Rp
bWVfdXNfZGVsdGEobm93LCB0eF9wcml2LT54bWl0X3RpbWVzdGFtcCk7Cit9CisKK2Jvb2wgd2Z4
X3R4X3F1ZXVlc19oYXNfY2FiKHN0cnVjdCB3ZnhfdmlmICp3dmlmKQoreworCWludCBpOworCisJ
aWYgKHd2aWYtPnZpZi0+dHlwZSAhPSBOTDgwMjExX0lGVFlQRV9BUCkKKwkJcmV0dXJuIGZhbHNl
OworCWZvciAoaSA9IDA7IGkgPCBJRUVFODAyMTFfTlVNX0FDUzsgKytpKQorCQkvKiBOb3RlOiBz
aW5jZSBvbmx5IEFQIGNhbiBoYXZlIG1jYXN0IGZyYW1lcyBpbiBxdWV1ZSBhbmQgb25seQorCQkg
KiBvbmUgdmlmIGNhbiBiZSBBUCwgYWxsIHF1ZXVlZCBmcmFtZXMgaGFzIHNhbWUgaW50ZXJmYWNl
IGlkCisJCSAqLworCQlpZiAoIXNrYl9xdWV1ZV9lbXB0eV9sb2NrbGVzcygmd3ZpZi0+dHhfcXVl
dWVbaV0uY2FiKSkKKwkJCXJldHVybiB0cnVlOworCXJldHVybiBmYWxzZTsKK30KKworc3RhdGlj
IGludCB3ZnhfdHhfcXVldWVfZ2V0X3dlaWdodChzdHJ1Y3Qgd2Z4X3F1ZXVlICpxdWV1ZSkKK3sK
KwlyZXR1cm4gYXRvbWljX3JlYWQoJnF1ZXVlLT5wZW5kaW5nX2ZyYW1lcykgKiBxdWV1ZS0+cHJp
b3JpdHk7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqd2Z4X3R4X3F1ZXVlc19nZXRfc2ti
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCXN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlc1tJRUVF
ODAyMTFfTlVNX0FDUyAqIEFSUkFZX1NJWkUod2Rldi0+dmlmKV07CisJaW50IGksIGosIG51bV9x
dWV1ZXMgPSAwOworCXN0cnVjdCB3ZnhfdmlmICp3dmlmOworCXN0cnVjdCBoaWZfbXNnICpoaWY7
CisJc3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCS8qIHNvcnQgdGhlIHF1ZXVlcyAqLworCXd2aWYg
PSBOVUxMOworCXdoaWxlICgod3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3dmlmKSkgIT0gTlVM
TCkgeworCQlmb3IgKGkgPSAwOyBpIDwgSUVFRTgwMjExX05VTV9BQ1M7IGkrKykgeworCQkJV0FS
Tl9PTihudW1fcXVldWVzID49IEFSUkFZX1NJWkUocXVldWVzKSk7CisJCQlxdWV1ZXNbbnVtX3F1
ZXVlc10gPSAmd3ZpZi0+dHhfcXVldWVbaV07CisJCQlmb3IgKGogPSBudW1fcXVldWVzOyBqID4g
MDsgai0tKQorCQkJCWlmICh3ZnhfdHhfcXVldWVfZ2V0X3dlaWdodChxdWV1ZXNbal0pIDwKKwkJ
CQkgICAgd2Z4X3R4X3F1ZXVlX2dldF93ZWlnaHQocXVldWVzW2ogLSAxXSkpCisJCQkJCXN3YXAo
cXVldWVzW2ogLSAxXSwgcXVldWVzW2pdKTsKKwkJCW51bV9xdWV1ZXMrKzsKKwkJfQorCX0KKwor
CXd2aWYgPSBOVUxMOworCXdoaWxlICgod3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3dmlmKSkg
IT0gTlVMTCkgeworCQlpZiAoIXd2aWYtPmFmdGVyX2R0aW1fdHhfYWxsb3dlZCkKKwkJCWNvbnRp
bnVlOworCQlmb3IgKGkgPSAwOyBpIDwgbnVtX3F1ZXVlczsgaSsrKSB7CisJCQlza2IgPSBza2Jf
ZGVxdWV1ZSgmcXVldWVzW2ldLT5jYWIpOworCQkJaWYgKCFza2IpCisJCQkJY29udGludWU7CisJ
CQkvKiBOb3RlOiBzaW5jZSBvbmx5IEFQIGNhbiBoYXZlIG1jYXN0IGZyYW1lcyBpbiBxdWV1ZQor
CQkJICogYW5kIG9ubHkgb25lIHZpZiBjYW4gYmUgQVAsIGFsbCBxdWV1ZWQgZnJhbWVzIGhhcwor
CQkJICogc2FtZSBpbnRlcmZhY2UgaWQKKwkJCSAqLworCQkJaGlmID0gKHN0cnVjdCBoaWZfbXNn
ICopc2tiLT5kYXRhOworCQkJV0FSTl9PTihoaWYtPmludGVyZmFjZSAhPSB3dmlmLT5pZCk7CisJ
CQlXQVJOX09OKHF1ZXVlc1tpXSAhPQorCQkJCSZ3dmlmLT50eF9xdWV1ZVtza2JfZ2V0X3F1ZXVl
X21hcHBpbmcoc2tiKV0pOworCQkJYXRvbWljX2luYygmcXVldWVzW2ldLT5wZW5kaW5nX2ZyYW1l
cyk7CisJCQl0cmFjZV9xdWV1ZXNfc3RhdHMod2RldiwgcXVldWVzW2ldKTsKKwkJCXJldHVybiBz
a2I7CisJCX0KKwkJLyogTm8gbW9yZSBtdWx0aWNhc3QgdG8gc2VudCAqLworCQl3dmlmLT5hZnRl
cl9kdGltX3R4X2FsbG93ZWQgPSBmYWxzZTsKKwkJc2NoZWR1bGVfd29yaygmd3ZpZi0+dXBkYXRl
X3RpbV93b3JrKTsKKwl9CisKKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3F1ZXVlczsgaSsrKSB7CisJ
CXNrYiA9IHNrYl9kZXF1ZXVlKCZxdWV1ZXNbaV0tPm5vcm1hbCk7CisJCWlmIChza2IpIHsKKwkJ
CWF0b21pY19pbmMoJnF1ZXVlc1tpXS0+cGVuZGluZ19mcmFtZXMpOworCQkJdHJhY2VfcXVldWVz
X3N0YXRzKHdkZXYsIHF1ZXVlc1tpXSk7CisJCQlyZXR1cm4gc2tiOworCQl9CisJfQorCXJldHVy
biBOVUxMOworfQorCitzdHJ1Y3QgaGlmX21zZyAqd2Z4X3R4X3F1ZXVlc19nZXQoc3RydWN0IHdm
eF9kZXYgKndkZXYpCit7CisJc3RydWN0IHdmeF90eF9wcml2ICp0eF9wcml2OworCXN0cnVjdCBz
a19idWZmICpza2I7CisKKwlpZiAoYXRvbWljX3JlYWQoJndkZXYtPnR4X2xvY2spKQorCQlyZXR1
cm4gTlVMTDsKKwlza2IgPSB3ZnhfdHhfcXVldWVzX2dldF9za2Iod2Rldik7CisJaWYgKCFza2Ip
CisJCXJldHVybiBOVUxMOworCXNrYl9xdWV1ZV90YWlsKCZ3ZGV2LT50eF9wZW5kaW5nLCBza2Ip
OworCXdha2VfdXAoJndkZXYtPnR4X2RlcXVldWUpOworCXR4X3ByaXYgPSB3Znhfc2tiX3R4X3By
aXYoc2tiKTsKKwl0eF9wcml2LT54bWl0X3RpbWVzdGFtcCA9IGt0aW1lX2dldCgpOworCXJldHVy
biAoc3RydWN0IGhpZl9tc2cgKilza2ItPmRhdGE7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3F1ZXVlLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L3F1ZXVlLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5l
ZGQwZDAxOGIxOTgKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L3F1ZXVlLmgKQEAgLTAsMCArMSw0NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb25seSAqLworLyoKKyAqIFF1ZXVlIGJldHdlZW4gdGhlIHR4IG9wZXJhdGlv
biBhbmQgdGhlIGJoIHdvcmtxdWV1ZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwg
U2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJp
Y3Nzb24KKyAqLworI2lmbmRlZiBXRlhfUVVFVUVfSAorI2RlZmluZSBXRlhfUVVFVUVfSAorCisj
aW5jbHVkZSA8bGludXgvc2tidWZmLmg+CisjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+CisKK3N0
cnVjdCB3ZnhfZGV2Oworc3RydWN0IHdmeF92aWY7CisKK3N0cnVjdCB3ZnhfcXVldWUgeworCXN0
cnVjdCBza19idWZmX2hlYWQJbm9ybWFsOworCXN0cnVjdCBza19idWZmX2hlYWQJY2FiOyAvKiBD
b250ZW50IEFmdGVyIChEVElNKSBCZWFjb24gKi8KKwlhdG9taWNfdAkJcGVuZGluZ19mcmFtZXM7
CisJaW50CQkJcHJpb3JpdHk7Cit9OworCit2b2lkIHdmeF90eF9sb2NrKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2KTsKK3ZvaWQgd2Z4X3R4X3VubG9jayhzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7Cit2b2lk
IHdmeF90eF9mbHVzaChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7Cit2b2lkIHdmeF90eF9sb2NrX2Zs
dXNoKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKKwordm9pZCB3ZnhfdHhfcXVldWVzX2luaXQoc3Ry
dWN0IHdmeF92aWYgKnd2aWYpOwordm9pZCB3ZnhfdHhfcXVldWVzX2NoZWNrX2VtcHR5KHN0cnVj
dCB3ZnhfdmlmICp3dmlmKTsKK2Jvb2wgd2Z4X3R4X3F1ZXVlc19oYXNfY2FiKHN0cnVjdCB3Znhf
dmlmICp3dmlmKTsKK3ZvaWQgd2Z4X3R4X3F1ZXVlc19wdXQoc3RydWN0IHdmeF92aWYgKnd2aWYs
IHN0cnVjdCBza19idWZmICpza2IpOworc3RydWN0IGhpZl9tc2cgKndmeF90eF9xdWV1ZXNfZ2V0
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKKworYm9vbCB3ZnhfdHhfcXVldWVfZW1wdHkoc3RydWN0
IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlKTsKK3ZvaWQgd2Z4X3R4X3F1
ZXVlX2Ryb3Aoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlLAor
CQkgICAgICAgc3RydWN0IHNrX2J1ZmZfaGVhZCAqZHJvcHBlZCk7CisKK3N0cnVjdCBza19idWZm
ICp3ZnhfcGVuZGluZ19nZXQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBwYWNrZXRfaWQpOwor
dm9pZCB3ZnhfcGVuZGluZ19kcm9wKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVm
Zl9oZWFkICpkcm9wcGVkKTsKK3Vuc2lnbmVkIGludCB3ZnhfcGVuZGluZ19nZXRfcGt0X3VzX2Rl
bGF5KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LAorCQkJCQkgIHN0cnVjdCBza19idWZmICpza2IpOwor
dm9pZCB3ZnhfcGVuZGluZ19kdW1wX29sZF9mcmFtZXMoc3RydWN0IHdmeF9kZXYgKndkZXYsIHVu
c2lnbmVkIGludCBsaW1pdF9tcyk7CisKKyNlbmRpZgotLSAKMi4zMy4wCgo=

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108E7B0A61
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjI0Qdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI0Qdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4163AF4;
        Wed, 27 Sep 2023 09:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpELk2KNHmZKh5JJMfKgPn8PmAfK5r7iJaNS2moStgzm9wF5/u3mbBbapkyluXAIFqHzVmZNcMFJ8vXFNm8QEF0tY4bivXTfub7/QGjnnVrfxlh6WP6SSBBDZA7kesJ9R2xSqEd9t3drYgJ7XhBjcgMeoh2Yr9x14YCFxFDF5RZnlVIrWIb3rsI0bIsrIDOp64SMSUjxZ8z5PJ/6CRcZn9fxqKcjvfF5xxUbZy19ZsKlj5eANsyzw0MloiKsAq67UPJ6ryPehDDMoqrcKFYa50zxlbUFAZ67J+JxRQRC0K5I2KxYzANa/QjLRpyb6RN5lITC+k2vU58pwMUt8t8vCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWc8E8CMbVgT7TANNR/8TdPGoMSnLO96cJPktBpnkXU=;
 b=mQIJMyPAmjrs/MF1PdhMdEZ3wHnhCeMN0mrCvqmSoKU99hTaY7uKboVGX4tnGog1G+ClvnUyeIZxk2rDVJyxP4j+FWndHVhSm9iGYAUf7owvO2/+hXrSJ1l8q5UPUHnhTEQPXVbBsEcOycVU9MQVvxi7g7A0yQmR6y/yEbZYcLLYY797kFA+v2KKhTp0wqEymAONk3ekjcKA/WK/eMR4VMIVjo+AV6rjQXgZx4WzrsUIrqMl5ZyHcAc7NUHWTccbT0UKWA4im5sU1LNKzhQqqyMHHNJm2GA7yhtg5w+OKJfKEVfY+7TlXl0Z+NRASlszXoTOqUg1fM0vteMKlw3J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWc8E8CMbVgT7TANNR/8TdPGoMSnLO96cJPktBpnkXU=;
 b=nlGA+udS0PDn21uITccIx8uV/TcmKiqkFDo/05wU77XWtAWMdlSLtR5KsChqrYORFwa/zYSf/1IgBRFZJxLrdY9x+lBlaOSnXLhG4FasDPwjL5qMsFQVe2j58He03hId+uoqYwcDN1U5gVlPT5mhS468HuIdZNI3FCBNrsb2/u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 16:33:28 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:28 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 8/9] wifi: wfx: scan_lock is global to the device
Date:   Wed, 27 Sep 2023 18:32:56 +0200
Message-Id: <20230927163257.568496-9-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0d3edb-924d-441d-5285-08dbbf777a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNHZwuDX1xdrqSk3M5kfh5GTvDMI05FM8f9Plok1OeCjhsIAWmPJzQwCfGGAFABAU1cd6g2NBOMqyRPSeiAsLa7lT/+fPneTw3SCVJ/WplHkN1d4hIRu5gEMvWr/XGmUdwVvyYB8d5uCp4w6Sexcgx8GaVnrLy287Sv6QUAdoUQ1syQaz76aW7EzikUxpdzsoZ8MJgoixDBfWuckrScf4+0aNYptJiGUCSwryfy4/F7DBFjBFB5PiMJez9yabXxwU+26I1n/mbCKaYn6rx1r0IfWsLX1uekjVO8FGCKg5zfoBcqCT9VLheDfViNTYOQfFRkjiBhw8+fjmUpyRWDx02i46SblSfQ0WGD4tePzF/UfaaZDHra+zrvcOYO3ErGmDWAAbb6yWTmkkTThzy3lAfJET9LUy8N/u/0O9sZ6jsJ4V0OhzUQtd9fXgrb2CvlvoFpzcE2M1FHUQxMfk46uku2ttfAEhzkDtvH3e42Uh/iVHpqZbfytE05AoQ8vVwGRmirWkzq4pkhgwDa723na+gvFepQC5jV2pXPhqonD/sv6htu6xFPtdghrs16BIxRP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39850400004)(376002)(230922051799003)(451199024)(186009)(1800799009)(36756003)(86362001)(8936002)(107886003)(6486002)(8676002)(2906002)(38100700002)(4326008)(6512007)(41300700001)(83380400001)(66556008)(5660300002)(1076003)(66574015)(2616005)(52116002)(6506007)(6916009)(66476007)(66946007)(316002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJTVmtzRWE0V1k5VXc4RUMrenBKaU1YYkIzbzFDbi9SUkw5bWZyU0lzcUlI?=
 =?utf-8?B?QW9RZDNCbzRoVXUzcllJWnNvOUU0MlZXNU1uZXhtQ0N1NW0xQm9ualArZ3hI?=
 =?utf-8?B?M0kzWmN1OGhVUEc2Qkk5c2lWTXdlTlRTekVMbTVWSW5wekdBWUJlRmJZYmJJ?=
 =?utf-8?B?cGpNUXNCaFB6eEJ4UWIwazhKdjNKT0krV0Uvd05uSVpsVHJjSlBpNEwwYlFh?=
 =?utf-8?B?NnhSWjhKdnJ5V2ZzSTZUREdZRUNWdUtINm9Gc0VIRmRzS1poR2xJYjcwd0Jr?=
 =?utf-8?B?T2thbzJIZTAwcTBzUldpQWRIOW1sVnowbHVJcFRnbzhsbmU5cWphd0Z2SXEy?=
 =?utf-8?B?ZnZweU9SMys1N0RsL011NGZoazFtS2JLZ3ZhSXFKamRUTks2Vk51REJDLy95?=
 =?utf-8?B?RmxjL2VINjdabFhGL1EvSkpxQVYrNnRhS2VmOUUrd0x1eXZSM3JBTjJZYmZk?=
 =?utf-8?B?K0EwZkM0N1MwU0FZNkhvc2prVGxJak9MN3ZPYmhJdHFFMUdSd05lenVNbXJr?=
 =?utf-8?B?OFdNcTdFYThxb0hLTkR6bXAxNERkMkk1ZXVGN0I0QkUxWHlhNnhzWER1THZF?=
 =?utf-8?B?NUdUa3AzM1VYbklFVC9Qa2Z4dWZ0YnF2eWpFbUVQMU1Va3g2QWR2UXg1Vmt5?=
 =?utf-8?B?d3JuNklYTTRNcnEvQUYza0tiVEZLWGNUNzFTYmVFRU9uazEwTnFocDRjMFJz?=
 =?utf-8?B?NzZDYzFDN2tUajN4R2pPd09QQWl5dTZicVQrdk5HdFcyeUdPTDBlWGdFVnRM?=
 =?utf-8?B?UkJhenJGWVBGM2ZsNDRUOEk3WkdDaFlBWXBCYWtKUG8zRkNxTC9ZbmRTZ1BT?=
 =?utf-8?B?eDFaaTNiVUdYZDdJVEtNdUZVeHlrbGJtZWdSNlRGT0tuOVp2TzlwNC8wQmxx?=
 =?utf-8?B?b1ZIM2hWZUdaUS9MaW8rME1OZis4aHZFb2VhSkc3Zy8zVjYxRnoyVEVOSU9G?=
 =?utf-8?B?cXc2eVlkSkJORFlQSEgrTm9OZG5rZGNtTzRGaXByS3c0TEJzQUxwZTJBbWh4?=
 =?utf-8?B?UjlmTE9aWm1DdDhBT1NhZEg4NzlYVkUyTlhFUW5wcVNYdGJsQ2pCckc2SU5k?=
 =?utf-8?B?Z2dQRVhuVlNML0svb25wZzdEdmtIanFiTHdwNjRPbUljdE9IU2FxUTRGQUpQ?=
 =?utf-8?B?UFRDYUNjb2FjckhBOUx4WkpWeGVuOEJMT1Z3Z3RNMjd3TFg0ZGprY2xZOVU4?=
 =?utf-8?B?VGJDWU1aUk5Bb3R6WEdyc0luWjRVY0JnZTNtS3g4MElzMG5DNjFyaHNnVEJQ?=
 =?utf-8?B?MFBqY0IrTFB6VDAwdE1UbU1YdkVnaHNNU1A0enRRcFBDdmlzSmRRUHJoSDBJ?=
 =?utf-8?B?OXdVM2ZRZnVCbVJsWGdRTmlIdDlQL0tWaDdYUWpUNWN6RHdvdlYxb0FLZUdy?=
 =?utf-8?B?NE1xOU9mTWw3L21vSEh6Zk1oZ3Vrd0ZNdSsrR1R5SjJpam5WMkh5UHNyYnEw?=
 =?utf-8?B?TVJNOEQvbjdxS1phV3Y3bHU0R3d3dldoTHk2VVlXbG9IV1J0ZHNyTVpUVUt1?=
 =?utf-8?B?bnUwazhSOHFmUXRCakZYTC81Sm5UTG1HRnZRd3lLeWxZTDBZbTFmRHo3Z2Js?=
 =?utf-8?B?S1VaYnc2QzhTcmgvcGI3ZzZ2MDNFZk1NM1NnODkydDY1bG4xSkhWUGk2TEZs?=
 =?utf-8?B?VGxURk5hbkpHR29lRE94N0NkZ2VUVTF1V3EyREI3QjV4NVB4aTVhaW5GUUV0?=
 =?utf-8?B?SEozeVA2VmhvVmpMeHVtc2FYcURVZ29hUzcxc2s1S0tZNk01N04xRmQ5UXcz?=
 =?utf-8?B?UmJDLzR1TUlmUHVVWkRrZ1F2T3R0MEFCTFV6R1l2K29mM0hIZUJPVms3UzNO?=
 =?utf-8?B?VGI1M3VldWtVZUwvS2hGL2U2OGp0Sks4dEdRa0tzaHpxdEVtcTU3YXhhNSsr?=
 =?utf-8?B?RDlXdXY3RGpBUmx4bjRLNUsvbmpUZXhGTElvRVBMVHNpREE0WWR5a2wxRUx5?=
 =?utf-8?B?TWUxUUI5YXUweTBrOVVlNXNJMVJXOS9aRWY5YkVTV3pqRDF1cWlUREdDRjVB?=
 =?utf-8?B?ODl1T20xMlE2ZU03cjdFbWVFeGVXbWlBeENJYWxqNWJIQTFBemhnUkI4K3lQ?=
 =?utf-8?B?M2Z6RDF0OTdMY0s5Um5qTWZYR1ROeU5UQWhITGMzT3BUMzgrRFFmWjYwWTVH?=
 =?utf-8?B?bTdlV0l5d0RIRExBY203dnpCQTVaZ2JlQTZoankrcFRvWTRRVURtR3RtL3Yy?=
 =?utf-8?Q?AiLMvXpNLTQo0GsJUjVXq9KMdGceVaahyxJfMqmphDaz?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0d3edb-924d-441d-5285-08dbbf777a4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:27.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPD1v/0t2Qy8oROJcBdsSmzRxTUA8waaQcYkDB8kyKsYt4PFmQi5CRrVKNieamdBcwM6ySqy+3U2sG1ay/fLvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Q3VycmVudGx5LCBvbmUgc2Nhbl9sb2NrIGlzIGFzc29jaWF0ZWQgdG8gZWFjaCB2aWYuIEhvd2V2
ZXIsIGNvbmN1cnJlbnQKc2NhbiBvbiB2aWZzIGlzIGV4cGxpY2l0bHkgcHJvaGl0aWJlZCBieSB0
aGUgZGV2aWNlLiBDdXJyZW50bHksCnNjYW5fbG9jayBpcyBhc3NvY2lhdGVkIHdpdGggY29uZl9t
dXRleCB0aGF0IGVuc3VyZSB0aGF0IGNvbmN1cnJlbnQgc2NhbgpvbiB2aWZzIGNhbm5vdCBoYXBw
ZW4uCgpJbiB0aGUgb25seSBjYXNlIHdoZXJlIGNvbmZfbXV0ZXggaXMgbm90IGFzc29jaWF0ZWQg
dG8gc2Nhbl9sb2NrLCB0aGUKc2Nhbl9sb2NrIGlzIHRlc3RlZCBvbiBhbGwgaW50ZXJmYWNlcy4K
ClNvLCB0aGlzIHBhdGNoIHJlbG9jYXRlIHNjYW5fbG9jayB0byB0aGUgZGV2aWNlIGFuZCBzaW1w
bGlmeSB0aGUgY29kZS4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUu
cG91aWxsZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4
L21haW4uYyAgfCAgMiArKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5j
IHwgIDYgKystLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uYyAgfCAg
OCArKysrLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyAgIHwgMTUg
KysrKy0tLS0tLS0tLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5oICAg
fCAgMyArLS0KIDUgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYwppbmRleCAzMWY2ZTBkM2Rj
MDg5Li5lNzE5ODUyMGJkZmZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L21haW4uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4u
YwpAQCAtMjQ4LDYgKzI0OCw3IEBAIHN0YXRpYyB2b2lkIHdmeF9mcmVlX2NvbW1vbih2b2lkICpk
YXRhKQogCiAJbXV0ZXhfZGVzdHJveSgmd2Rldi0+dHhfcG93ZXJfbG9vcF9pbmZvX2xvY2spOwog
CW11dGV4X2Rlc3Ryb3koJndkZXYtPnJ4X3N0YXRzX2xvY2spOworCW11dGV4X2Rlc3Ryb3koJndk
ZXYtPnNjYW5fbG9jayk7CiAJbXV0ZXhfZGVzdHJveSgmd2Rldi0+Y29uZl9tdXRleCk7CiAJaWVl
ZTgwMjExX2ZyZWVfaHcod2Rldi0+aHcpOwogfQpAQCAtMzE3LDYgKzMxOCw3IEBAIHN0cnVjdCB3
ZnhfZGV2ICp3ZnhfaW5pdF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3Qg
d2Z4X3BsYXRmb3JtX2RhCiAJCWdwaW9kX3NldF9jb25zdW1lcl9uYW1lKHdkZXYtPnBkYXRhLmdw
aW9fd2FrZXVwLCAid2Z4IHdha2V1cCIpOwogCiAJbXV0ZXhfaW5pdCgmd2Rldi0+Y29uZl9tdXRl
eCk7CisJbXV0ZXhfaW5pdCgmd2Rldi0+c2Nhbl9sb2NrKTsKIAltdXRleF9pbml0KCZ3ZGV2LT5y
eF9zdGF0c19sb2NrKTsKIAltdXRleF9pbml0KCZ3ZGV2LT50eF9wb3dlcl9sb29wX2luZm9fbG9j
ayk7CiAJaW5pdF9jb21wbGV0aW9uKCZ3ZGV2LT5maXJtd2FyZV9yZWFkeSk7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3F1ZXVlLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L3F1ZXVlLmMKaW5kZXggYjU5NzVkMThmMDliNC4uZTYxYjg2ZjIx
MWU1MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5j
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuYwpAQCAtMjY3LDEw
ICsyNjcsOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKndmeF90eF9xdWV1ZXNfZ2V0X3NrYihz
dHJ1Y3Qgd2Z4X2RldiAqd2RldikKIAkJfQogCX0KIAotCXd2aWYgPSBOVUxMOwotCXdoaWxlICgo
d3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3dmlmKSkgIT0gTlVMTCkKLQkJaWYgKG11dGV4X2lz
X2xvY2tlZCgmd3ZpZi0+c2Nhbl9sb2NrKSkKLQkJCXJldHVybiBOVUxMOworCWlmIChtdXRleF9p
c19sb2NrZWQoJndkZXYtPnNjYW5fbG9jaykpCisJCXJldHVybiBOVUxMOwogCiAJd3ZpZiA9IE5V
TEw7CiAJd2hpbGUgKCh3dmlmID0gd3ZpZl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKSB7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jCmluZGV4IDgxN2VlYjNhYThiZmYu
LmMzYzEwM2ZmODhjY2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvc2Nhbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jCkBA
IC05NSw3ICs5NSw3IEBAIHZvaWQgd2Z4X2h3X3NjYW5fd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspCiAJaW50IGNoYW5fY3VyLCByZXQsIGVycjsKIAogCW11dGV4X2xvY2soJnd2aWYtPndk
ZXYtPmNvbmZfbXV0ZXgpOwotCW11dGV4X2xvY2soJnd2aWYtPnNjYW5fbG9jayk7CisJbXV0ZXhf
bG9jaygmd3ZpZi0+d2Rldi0+c2Nhbl9sb2NrKTsKIAlpZiAod3ZpZi0+am9pbl9pbl9wcm9ncmVz
cykgewogCQlkZXZfaW5mbyh3dmlmLT53ZGV2LT5kZXYsICJhYm9ydCBpbi1wcm9ncmVzcyBSRVFf
Sk9JTiIpOwogCQl3ZnhfcmVzZXQod3ZpZik7CkBAIC0xMTYsNyArMTE2LDcgQEAgdm9pZCB3Znhf
aHdfc2Nhbl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJCXJldCA9IC1FVElNRURP
VVQ7CiAJCX0KIAl9IHdoaWxlIChyZXQgPj0gMCAmJiBjaGFuX2N1ciA8IGh3X3JlcS0+cmVxLm5f
Y2hhbm5lbHMpOwotCW11dGV4X3VubG9jaygmd3ZpZi0+c2Nhbl9sb2NrKTsKKwltdXRleF91bmxv
Y2soJnd2aWYtPndkZXYtPnNjYW5fbG9jayk7CiAJbXV0ZXhfdW5sb2NrKCZ3dmlmLT53ZGV2LT5j
b25mX211dGV4KTsKIAl3ZnhfaWVlZTgwMjExX3NjYW5fY29tcGxldGVkX2NvbXBhdCh3dmlmLT53
ZGV2LT5odywgcmV0IDwgMCk7CiB9CkBAIC0xNTUsNyArMTU1LDcgQEAgdm9pZCB3ZnhfcmVtYWlu
X29uX2NoYW5uZWxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAkvKiBIaWphY2sg
c2NhbiByZXF1ZXN0IHRvIGltcGxlbWVudCBSZW1haW4tT24tQ2hhbm5lbCAqLwogCW11dGV4X2xv
Y2soJnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgpOwotCW11dGV4X2xvY2soJnd2aWYtPnNjYW5fbG9j
ayk7CisJbXV0ZXhfbG9jaygmd3ZpZi0+d2Rldi0+c2Nhbl9sb2NrKTsKIAlpZiAod3ZpZi0+am9p
bl9pbl9wcm9ncmVzcykgewogCQlkZXZfaW5mbyh3dmlmLT53ZGV2LT5kZXYsICJhYm9ydCBpbi1w
cm9ncmVzcyBSRVFfSk9JTiIpOwogCQl3ZnhfcmVzZXQod3ZpZik7CkBAIC0xNzgsNyArMTc4LDcg
QEAgdm9pZCB3ZnhfcmVtYWluX29uX2NoYW5uZWxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCiAJCWRldl9lcnIod3ZpZi0+d2Rldi0+ZGV2LCAicm9jIGRpZG4ndCBzdG9wXG4iKTsKIAlp
ZWVlODAyMTFfcmVtYWluX29uX2NoYW5uZWxfZXhwaXJlZCh3dmlmLT53ZGV2LT5odyk7CiBlbmQ6
Ci0JbXV0ZXhfdW5sb2NrKCZ3dmlmLT5zY2FuX2xvY2spOworCW11dGV4X3VubG9jaygmd3ZpZi0+
d2Rldi0+c2Nhbl9sb2NrKTsKIAltdXRleF91bmxvY2soJnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgp
OwogCXdmeF9iaF9yZXF1ZXN0X3R4KHd2aWYtPndkZXYpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93Zngvc3RhLmMKaW5kZXggZjQyMzQxYzJiYWZmYi4uNDk2YjkzZGUzZWU1OCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYworKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCkBAIC05Nyw5ICs5Nyw4IEBAIHZvaWQgd2Z4
X2NvbmZpZ3VyZV9maWx0ZXIoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHVuc2lnbmVkIGludCBj
aGFuZ2VkX2ZsYWdzLAogCQkJRklGX1BST0JFX1JFUSB8IEZJRl9QU1BPTEw7CiAKIAltdXRleF9s
b2NrKCZ3ZGV2LT5jb25mX211dGV4KTsKKwltdXRleF9sb2NrKCZ3ZGV2LT5zY2FuX2xvY2spOwog
CXdoaWxlICgod3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3dmlmKSkgIT0gTlVMTCkgewotCQlt
dXRleF9sb2NrKCZ3dmlmLT5zY2FuX2xvY2spOwotCiAJCS8qIE5vdGU6IEZJRl9CQ05fUFJCUkVT
UF9QUk9NSVNDIGNvdmVycyBwcm9iZSByZXNwb25zZSBhbmQKIAkJICogYmVhY29ucyBmcm9tIG90
aGVyIEJTUwogCQkgKi8KQEAgLTEyNiw5ICsxMjUsOCBAQCB2b2lkIHdmeF9jb25maWd1cmVfZmls
dGVyKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1bnNpZ25lZCBpbnQgY2hhbmdlZF9mbGFncywK
IAkJZWxzZQogCQkJZmlsdGVyX3ByYnJlcSA9IHRydWU7CiAJCXdmeF9oaWZfc2V0X3J4X2ZpbHRl
cih3dmlmLCBmaWx0ZXJfYnNzaWQsIGZpbHRlcl9wcmJyZXEpOwotCi0JCW11dGV4X3VubG9jaygm
d3ZpZi0+c2Nhbl9sb2NrKTsKIAl9CisJbXV0ZXhfdW5sb2NrKCZ3ZGV2LT5zY2FuX2xvY2spOwog
CW11dGV4X3VubG9jaygmd2Rldi0+Y29uZl9tdXRleCk7CiB9CiAKQEAgLTYyMSwxOCArNjE5LDE0
IEBAIGludCB3Znhfc2V0X3RpbShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4
MDIxMV9zdGEgKnN0YSwgYm9vbCBzZXQpCiAKIHZvaWQgd2Z4X3N1c3BlbmRfcmVzdW1lX21jKHN0
cnVjdCB3ZnhfdmlmICp3dmlmLCBlbnVtIHN0YV9ub3RpZnlfY21kIG5vdGlmeV9jbWQpCiB7Ci0J
c3RydWN0IHdmeF92aWYgKnd2aWZfaXQ7Ci0KIAlpZiAobm90aWZ5X2NtZCAhPSBTVEFfTk9USUZZ
X0FXQUtFKQogCQlyZXR1cm47CiAKIAkvKiBEZXZpY2Ugd29uJ3QgYmUgYWJsZSB0byBob25vciBD
QUIgaWYgYSBzY2FuIGlzIGluIHByb2dyZXNzIG9uIGFueSBpbnRlcmZhY2UuIFByZWZlciB0bwog
CSAqIHNraXAgdGhpcyBEVElNIGFuZCB3YWl0IGZvciB0aGUgbmV4dCBvbmUuCiAJICovCi0Jd3Zp
Zl9pdCA9IE5VTEw7Ci0Jd2hpbGUgKCh3dmlmX2l0ID0gd3ZpZl9pdGVyYXRlKHd2aWYtPndkZXYs
IHd2aWZfaXQpKSAhPSBOVUxMKQotCQlpZiAobXV0ZXhfaXNfbG9ja2VkKCZ3dmlmX2l0LT5zY2Fu
X2xvY2spKQotCQkJcmV0dXJuOworCWlmIChtdXRleF9pc19sb2NrZWQoJnd2aWYtPndkZXYtPnNj
YW5fbG9jaykpCisJCXJldHVybjsKIAogCWlmICghd2Z4X3R4X3F1ZXVlc19oYXNfY2FiKHd2aWYp
IHx8IHd2aWYtPmFmdGVyX2R0aW1fdHhfYWxsb3dlZCkKIAkJZGV2X3dhcm4od3ZpZi0+d2Rldi0+
ZGV2LCAiaW5jb3JyZWN0IHNlcXVlbmNlICglZCBDQUIgaW4gcXVldWUpIiwKQEAgLTczMCw3ICs3
MjQsNiBAQCBpbnQgd2Z4X2FkZF9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0
cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCiAJY29tcGxldGUoJnd2aWYtPnNldF9wbV9tb2RlX2Nv
bXBsZXRlKTsKIAlJTklUX1dPUksoJnd2aWYtPnR4X3BvbGljeV91cGxvYWRfd29yaywgd2Z4X3R4
X3BvbGljeV91cGxvYWRfd29yayk7CiAKLQltdXRleF9pbml0KCZ3dmlmLT5zY2FuX2xvY2spOwog
CWluaXRfY29tcGxldGlvbigmd3ZpZi0+c2Nhbl9jb21wbGV0ZSk7CiAJSU5JVF9XT1JLKCZ3dmlm
LT5zY2FuX3dvcmssIHdmeF9od19zY2FuX3dvcmspOwogCUlOSVRfV09SSygmd3ZpZi0+cmVtYWlu
X29uX2NoYW5uZWxfd29yaywgd2Z4X3JlbWFpbl9vbl9jaGFubmVsX3dvcmspOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaCBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3NpbGFicy93Zngvd2Z4LmgKaW5kZXggNWZkODBjNDIzZDZmNi4uYmQwZGYyZTFlYTk5
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaAorKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5oCkBAIC00Myw2ICs0Myw3IEBA
IHN0cnVjdCB3ZnhfZGV2IHsKIAlzdHJ1Y3QgZGVsYXllZF93b3JrICAgICAgICBjb29saW5nX3Rp
bWVvdXRfd29yazsKIAlib29sICAgICAgICAgICAgICAgICAgICAgICBwb2xsX2lycTsKIAlib29s
ICAgICAgICAgICAgICAgICAgICAgICBjaGlwX2Zyb3plbjsKKwlzdHJ1Y3QgbXV0ZXggICAgICAg
ICAgICAgICBzY2FuX2xvY2s7CiAJc3RydWN0IG11dGV4ICAgICAgICAgICAgICAgY29uZl9tdXRl
eDsKIAogCXN0cnVjdCB3ZnhfaGlmX2NtZCAgICAgICAgIGhpZl9jbWQ7CkBAIC04MSw4ICs4Miw2
IEBAIHN0cnVjdCB3ZnhfdmlmIHsKIAogCXVuc2lnbmVkIGxvbmcgICAgICAgICAgICAgIHVhcHNk
X21hc2s7CiAKLQkvKiBhdm9pZCBzb21lIG9wZXJhdGlvbnMgaW4gcGFyYWxsZWwgd2l0aCBzY2Fu
ICovCi0Jc3RydWN0IG11dGV4ICAgICAgICAgICAgICAgc2Nhbl9sb2NrOwogCXN0cnVjdCB3b3Jr
X3N0cnVjdCAgICAgICAgIHNjYW5fd29yazsKIAlzdHJ1Y3QgY29tcGxldGlvbiAgICAgICAgICBz
Y2FuX2NvbXBsZXRlOwogCWludCAgICAgICAgICAgICAgICAgICAgICAgIHNjYW5fbmJfY2hhbl9k
b25lOwotLSAKMi4zOS4yCgo=

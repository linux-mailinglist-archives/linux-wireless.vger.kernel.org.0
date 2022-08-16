Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AF595D97
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiHPNnR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiHPNnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 09:43:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2019.outbound.protection.outlook.com [40.92.45.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299165FADD
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 06:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afVdS2o8rw2TuCUgtGrRJwItqht8HNJEosA62rZ1/CXdxQQq0pAVHfNKWvdYxRqmVBYLXBGD8zMlhvNn+W3Fy4lZvsVqUbmy6/xgAk2sbHhqirfOapYMXRN/zNDfnRvOr5GyA0EZpCVHkyqtEfXPHUXZOVDU+L1SHw8kIxwsEp0nZfkZHMr17b5UG+0q6H9H5HFPruQVIL2t9SWZfFtuCuhYz6jzPQPuaXb1l5krjk307/+Z4LMAKpb/luPwzIx7FVwpvJxzBpr+b2gbMNzzgYRDmPDzKhmj8ymx4H3e6J9wYB/76X7KHWoZ9SQ0n6gh0Ya0lSg8/Y/hvPC6ddbPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E8jhSR4iiBoSxXQ9Rfo3sJCBMsXkQHN9vtkfKbfZ+M=;
 b=WKidNfNZqyA9ePUZOwdulqNPirjFWZPma+cRTGGyKnsw4Guvo4XmDso8FybKkb5oOZ5l3dg8v5QE8dOSm3tRjHZnMHjEM5TkBP/r7V9wwulDmkyL6GgRbjEEjPq2eQy1TtJw0l+NwhiOI3ujWTtAVvMMdd2WzaKmBma8GhoHF0KU4ayp0Pzv+fVFrpvbxK7Qw+ZpilnpiQObJQT7AZFPcd70LD96qJfaXg/i7zG5E34Fp9HcV3RDapeGVAAK3sXiylRoeyhPSgiLQePXC/HrUTK+8AkwPrls/QPoDUr4+sUpIFlsqbjhh62BG8O3PuU6/IzUzxQACatwmvbMSFv50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E8jhSR4iiBoSxXQ9Rfo3sJCBMsXkQHN9vtkfKbfZ+M=;
 b=arveiL4V73XCZcrL9mbwZbMdzxrJ7TtNa8/kAA4aqCKJR67ekaYCKKAWRejSwPP69v9mohu+e1XCcu5anAw5AT4oyD3tEuj7OuWQBVziwgwrkhAysCjrviw6qo3OFZfVSwGJ8hDxM2/HhN+EEKYrU3QP1KHdOseKcTm3QKO6rTXEINED5N0PZcEZzpauLmjOZRWvaLzFdlt25pDWgPMMjsH0VXSNmoq1t8RVJXx8PaiuhbzbANIMSglmXw3hcnks7Qossvdbwx6oXNC/hHiaomd3llaxLi/q5oPXkZ+YAZBhHX6RI86x7EL2Uwmy/tNbJFvEMJjtabmiQ3JsNffNwA==
Received: from CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6)
 by DM4PR03MB6030.namprd03.prod.outlook.com (2603:10b6:5:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 13:43:12 +0000
Received: from CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::3c78:e9a0:677:922a]) by CO6PR03MB6241.namprd03.prod.outlook.com
 ([fe80::3c78:e9a0:677:922a%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 13:43:12 +0000
From:   Tao J <tao-j@outlook.com>
To:     mbizon@freebox.fr
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [RFC][PATCH] mac80211: fix VHT 160Mhz bandwidth when using extended NSS on PHY with NSS ratio
Date:   Tue, 16 Aug 2022 09:43:04 -0400
Message-ID: <CO6PR03MB6241B88F294355CFF555899CE16B9@CO6PR03MB6241.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <19cbe5dd1d7f0e194ed40c8db2cf2beffa3ae167.camel@freebox.fr>
References: <19cbe5dd1d7f0e194ed40c8db2cf2beffa3ae167.camel@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [K5D8L1PrQXEbPcJGo3eQuwQ/baOFy9Iq]
X-ClientProxiedBy: BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::31) To CO6PR03MB6241.namprd03.prod.outlook.com
 (2603:10b6:303:13b::6)
X-Microsoft-Original-Message-ID: <20220816134304.193996-1-tao-j@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0446d0ec-0bbf-4cc2-c2e0-08da7f8d42d5
X-MS-TrafficTypeDiagnostic: DM4PR03MB6030:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEmvScxJ49d6HWPPIoFquyMNf0nJ7FvdUvzIlgOC+EhPkkNbEi/fY23SyOB2rJy2FKazv8wng8EhZ1vOJMgrllVTRJhPsH9l9sh2M7E1LCP7a9mekfDZP7r1k72G0emdTGli9giJ9PjXvXzcARL9F6Whu4bWs7AhdIwdp+EEM3t2Bbm3xvRgZeI6qfltSpEtIVqH8pWIrQa03KrJCjDK4Y5plIqY5uamlJ62QetLftWvQqEHr9JfU27FYVHL2EDIsYcWcD9hYjrsM0bRDCkfF4xXk5zmBBApiKi431s1Hz82OSHu3TZB/iUK90h+/0G0UmUWr1Xm40u9oSInESuN781w98m1ExPTe6l25t3OKHcYunT2oE5ozCevCkeq4WNXVlQwxg3pV6czh1yN0FpTokBj4YLb0iX347MvU5SPgkudIVxwIsnBMn7gDHjVm62S6xckl3ARytbN2enirkmx7nBTJRSWrGC5z1L3c6Kfh2Z+6g7mDfRh+6yjty8ohttjVbprz0XEn6xNNiWfsL7RGqva2neU8HgQootJyP07rNGiodaRLaUccVHtv4ucAQUU5eLeVour0Jkbk0GOeMzi4ZnDQQMuIXBigJNt1U3KPjFi3TNvLfVK0PA3nCGuV2mcb+hF22X8A6bUkGLK1vswQ4Fybd/K/ngzaHG1Se4pjY+TB8TpMU2RDFH2QJ5+G683
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFQZWtOT0JycStDTVlRVTRHZWxKcFVXUnFmQmptMXBiMDdxMFdKK1ZSTGxt?=
 =?utf-8?B?SmY3a2tkN29YWS9qYm9xa2tZOHl0TGI5WGRPV2hsVmhvKzBPQWtYa0RSSDQ2?=
 =?utf-8?B?NkJWL0wwaFJ2U1NtY2FlREluQXhXMnczVXAwSFJIMjFsWlg3aHE2Z1FUdWh2?=
 =?utf-8?B?d3pqWllMclpKdXFvVGttbmZsY3BrblVRWTdjQnBUSkhZQ09zV0FMUE04Nzhs?=
 =?utf-8?B?dWV6WGpMbi9sQlBJRzRFc0lydlhVUnlOOFFqYzNkT2U0NUEzdGdxU2xUWGFz?=
 =?utf-8?B?OE5nNC9IbTZOVWV4S3JxSVdtNDlOMHZnTlRzYndsTjZTSTBpdVF1TVdlekV4?=
 =?utf-8?B?cWpBU05yMTRjSmJzNUZzeE50TVlaL1NUMGtOWWpsRTFKREdmSWlFZ1loM3c4?=
 =?utf-8?B?UW43VW1ReVV3Y0R4bWFscy9JQkw3Q2JQcDI4RnRwZk42TXNKT3NzRExTMmhH?=
 =?utf-8?B?ZmFwZk5sdUVaWDNmR1ZNYlhHWVF6Rm9CMTVpbHhSWTRMSGpkZjhJU0MrcVR2?=
 =?utf-8?B?WndjRHllZTM4WjU0UE80VXJoOVlFY2RId0tzam1nL1ZKbGNBNERyZTVKS3Vn?=
 =?utf-8?B?c1NUeXpVOTVCVEgyVlVUMzZEdGxRajllRWxXd2krb2ZMNlhod3RtMy9icG8w?=
 =?utf-8?B?QTJ1R2hVbEpZUmJ4T0pIUHNJTE5sa2pobUI1N0xXN25ta3BwM2VXc2dQME51?=
 =?utf-8?B?UlZLUE9GSWJRUml5VkJvTDhKcHUyZXl6UklZNFhmeG5SQWJmamJqdlFvK0VT?=
 =?utf-8?B?Q1NiRTlOVHYxOXp0RWRDUnpWdnUyOU40amV5ZjFDVFdkMTdWTyt2aFZGWjE0?=
 =?utf-8?B?b2IrVkNTMkl3WVpaN2swdmxzWHZVQ05RQnkxRmNjWk9QQ2tsQVNIVW5iVWxW?=
 =?utf-8?B?cmFQOW8rV1I3aTZnaTBCUCt4SjM4cGlOVWxpdU5RbFYydmRDKzdQc2dpeVo3?=
 =?utf-8?B?S0dhaHU4ZVIwaVd1Q1k4Q216Z1Fub2hLdGJLSkk3R2ppM3VYMTFqbXB2OVk1?=
 =?utf-8?B?ejhWdHU0Ym9NWkNLUzNpYTd3aEVGTGRiUmZqNzRqRXJZQVdTa0RIcXdMRWtt?=
 =?utf-8?B?aUlOSkUvaGNXc2QrL1JGaDdTSVRYZlhmSVExQVNEUG5VdEorR1JNaUxoY0lw?=
 =?utf-8?B?STM3SUwwTmVBQkZXOHdPWG9pUjNWanhVb1ViRGJvd0ZTcHJyU0U1UjltUVhl?=
 =?utf-8?B?RW5SUnRVd2p1MnNzTGppSW56YUp3UzlqM3hDRzhZaWt2dDNWdTc3blkvYlRx?=
 =?utf-8?B?RjFtZWhDcm1tdVd4RWlkdTFDUGlqcHZRWUZQVlBlQUlNTWhwbWtubnp1ZCs1?=
 =?utf-8?B?QVF3cHNzKzJwSDV1cmgxTXYvSDBSenZLNWJXUlZvTnRpYUxYaUVFOXpUd0No?=
 =?utf-8?B?L2NkbHdWWWU2K1ZPVitQZnVpcG1QL3lwVTBmTnU4L1k4NnVZaWkxVmVCMmdP?=
 =?utf-8?B?VGdMNUxyd0piM1hNbDdDVGlRRkhpVjRNRjFTTUQwRGtlWHVWVkxTd1FMVjMx?=
 =?utf-8?B?VlRHY0FoaGZnNEpaVGY1WWVCVjdZWWZjTHJCNUNVM29pc0tWTnR6K0ZSU0Vh?=
 =?utf-8?B?SnM3WTJiTnV5QmhsNWxiY1FUWm5GQVpaVkVkVS9FTG5ndkxhZTVKWDE2K1Q2?=
 =?utf-8?B?dWpEQzlBQ1BjYUlxZm16RlhtZXFUOHdsdVI4SnpKNnRIdFhsOGlFU2J1enFX?=
 =?utf-8?B?emlWV2hqWk82QnZTeEFxcHB1bzVGR0VIc2JZMlNRTjVYNHpjQWdQbzB3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0446d0ec-0bbf-4cc2-c2e0-08da7f8d42d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR03MB6241.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 13:43:12.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied on 5.19 and worked.

AP: QCA9984
STA：AX201

Before patch:
iw dev wlan-ax201 link
rx bitrate: 866 MBit/s VHT-MCS 9 160MHz short GI VHT-NSS 1
tx bitrate: 866 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2

After patch:
rx bitrate: 866 MBit/s VHT-MCS 9 160MHz short GI VHT-NSS 1
tx bitrate: 866 MBit/s VHT-MCS 9 160MHz short GI VHT-NSS 1

Notice that the tx rate did not change and the NSS reduced from 2 to 1.

But actually it should support VHT-NSS 2 and achieve 1733 MBit/s at least 
for rx bitrate (verified this with the same AP/STA using another OS,
 and iperf showed 1.2GBit/s).  Do you have any idea to fix that? 
Although it is beyond the scope of this patch.

with iw 5.19 ax201 showed
		VHT RX highest supported: 0 Mbps
		VHT TX highest supported: 0 Mbps
		VHT extended NSS: supported


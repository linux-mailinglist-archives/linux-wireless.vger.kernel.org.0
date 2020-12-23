Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC752E1EE1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 16:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgLWPoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Dec 2020 10:44:19 -0500
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:24001
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728907AbgLWPlZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Dec 2020 10:41:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npEa0iH5TS8su/dbjLIqfTxVEtHME1f4iGfqgqmGyfgjuQFWSHxPSy1IbPepjdQvMMcnZShY9XrQMM92ph8QfHLvibVyqo2vSbkZ0+GfvYenCsy4mwGpc0fKngft4NaN6mMOnfK13ltCKkTkGtAIgBK3LhcJ3veGggYLFK540o4IUkiC53fXu07KsJMA1UnPQLb9x4IU/bfEd5iuIoO3BURlWUHvFyAcYzx6AQ9aQsCMCDHEsce9frlxcDYZG8ikDzwnvlpj3YiuFDI8zsn18U8m7o+GpyhQM5P8PvTmiENx0GZf0VX8AydZwA0Y5wvANYJ1d581YIq9YGxwYDkUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScdKj0m7I7cWmEvMfoqQED9OSHuZgJYG+6raJ3ohj6g=;
 b=O5qdLyOn7QHFeObpTvnqzbvruzIsUOo5Fu462L+lI7uILPwtI1G+wVMw7ooMWqk5cmZwrgQ0tV42zWbpTFLBcBepmFAP1Lz3mH7s0oJpZp1yYCOU+G8uQIvzwXCtSLdM8oLm80q3OrH7Ugp2YpurllOJQgh0kGUEXGathhoRahi6mdtnGF34q0bnMyBnlUei7X2xRl4mjiq2kOK9kuULxPaYaoIUFc0UP7QVqKeqkGysPP4yau4viZR1l5DuqtpNTID6qo3xXZLz1CBB+wtIQjCw/aWW0WEFgX1ADy7f3EZPmsThtwY8ygarbYB8042OmEtsPVBcfGCxFIL9H7Vzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScdKj0m7I7cWmEvMfoqQED9OSHuZgJYG+6raJ3ohj6g=;
 b=ZpJf0O8Lf6ZekvrnGxMXxQG/H9Dyuex0+ztsvY1nwGRdgM95JI8S1kXU7Odz5Bx5W+JVBKgMp+lcGuikOjX3kSsXA5RjvBLQigmG2LkRJnrtYqjyLAtOyHkCYXI+nN/l/cDoX/sTt/OASmL+PAMjJLIbHo5cSEpiW44h1mzD4Vo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Wed, 23 Dec
 2020 15:40:03 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca%5]) with mapi id 15.20.3700.026; Wed, 23 Dec 2020
 15:40:03 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v4 09/24] wfx: add hwio.c/hwio.h
Date:   Wed, 23 Dec 2020 16:39:10 +0100
Message-Id: <20201223153925.73742-10-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223153925.73742-1-Jerome.Pouiller@silabs.com>
References: <20201223153925.73742-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SA0PR12CA0024.namprd12.prod.outlook.com (2603:10b6:806:6f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 15:40:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531609d7-4d55-4aca-75f3-08d8a75903f8
X-MS-TrafficTypeDiagnostic: SA0PR11MB4543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB45438A604EB411E6025D5E4A93DE0@SA0PR11MB4543.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOac5dxMpJZ+eb8Z/pNNRdASZQsz0IsKVTvLbKmJbUaI2q3v7+70V8NKMkXbtWd8KqFbtRND9SwbGWeZGuSlCUiXQ2Z8EtzewpmHxMWfMSl9zRtqGXJ+5NYnt6PeJqGrodGS1BHUOHlhqWTuXY3j82SJOHZ1TACfbbwomG8PEEE7y5+9jmGqaQfhihn91Ltuv9U3W1WdGkgUpigdBFxqlZMNqrIcivPa4uEsaaNwahkwO9gfQR/JdJvqW1c34lwM6rZ/pfCS7qkDizzC0ZWdSXYwKnDkzUIjMLqZqJfM9RpO1bBQZdM2cUcJHg7kaZIf6CoVZXBbrra+1jt4zfo0ptqDoHRhUyNCofd6dRpUVk6FDKiVPeBtTEMs0rxR/Bg5K6+WLPAR9/hh1x5YKprrHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39850400004)(5660300002)(956004)(30864003)(2616005)(66476007)(66556008)(86362001)(36756003)(107886003)(66574015)(66946007)(6486002)(4326008)(83380400001)(6666004)(8676002)(186003)(52116002)(16526019)(7416002)(478600001)(26005)(1076003)(316002)(7696005)(54906003)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFZ2d0JrUFIraXMzU1RzZllwTUVkamZxTmh2NTA4NGl1enV3WEY5Q0p0Q3Nh?=
 =?utf-8?B?dndSdGZEWTdqWU5SNkJadXJxd215cmJqTEpCbW94TFNWNGVhdkMvcUNNNlQx?=
 =?utf-8?B?ZlYwQ1BrOEJ6NlZxVmZIZ3o1MHEyWXp0QWF3K1JnL1hHVGw5MUdnVVhTTXZ2?=
 =?utf-8?B?ZG5LYmp4ekpWcGhLLzM4eTFLM0hXZUtRTFVFMjUvcnBqaXFKbVlTSkgwYTdx?=
 =?utf-8?B?YmVXY0hLeEZtVGoxa09vUkpvRU04NzYvUmxUVVcrM2h3VW9YdnNtOGZGVkhK?=
 =?utf-8?B?ckFCZ1AzTjluMjYyWmpwd3pTRDE5dFI1Vlk4eTNXV0Y5WDRHYTN1NW1mMVpk?=
 =?utf-8?B?OE9DZ1NFL01SeERtMU9wcjNvaDhPK0RtNE5oRkJpeU5waWZGd1N4UVJPNk44?=
 =?utf-8?B?STI5ZlJ4TEpCaGJhNHRjd2lTUUlPTXc4RGxIWkJua2l5SnhFWUxPK2J6UXpy?=
 =?utf-8?B?UkQxdW5SMXBoMENrOFZqeE9DcGhlR1N5cldTUTFOVTBTTHE5WTAxb3YzK3ky?=
 =?utf-8?B?ejFaYmErUTlWcHFYZlpkNmIyYkRDYTNXVzVGeXU1cHVheGxuZVlJVVgvVGhY?=
 =?utf-8?B?SGRSbE42TnVraVVCOXlIQXkzMjFIWTAyTVJoQ1JZOEtDSWpYNjNJdy80azFQ?=
 =?utf-8?B?RjRvblZSY1RQc0haZ0JSbzlzbVVwVGVKQW5oUXhoWmhpdTZkQ01mQnJKemo5?=
 =?utf-8?B?di9OVGtpUlc3NzZpcEF0WEYwZzJvR2pYK1JjaEpnUVE3ZU5FcWtPTHI4T0lm?=
 =?utf-8?B?QnBKek9vRVZKV1pZMmxSeTlNb1RNVjF4VVhkNmhiWWd0MnMxQ2NMMGZDM3Mv?=
 =?utf-8?B?MTVPT1NPRG0wd1U3WSs3WFNtRndhd0dUZmpDNGhDeHRSMDFFVXV1eTIxaTVQ?=
 =?utf-8?B?RVhZK205OVBuYjRJb3pYYTFTaEU2UThIRzNGWFkzd3krQmtLYk5lM2FwUU1j?=
 =?utf-8?B?NUdrR1RVeTdvUDlwRTRmb09rb294d2t2TWl4MDNWVStlaWRjOUF4OHMwMnph?=
 =?utf-8?B?YUxkYUlCRkNBUWY2WmV6cWM3WU8rSkxIdSs3cHB4YXU3aEVWOGlkNnZ0SzJy?=
 =?utf-8?B?TzAvSDlQQjAzZnduV2JYcXQ0OFVKU2hPbnBTci9NNzU4R25wMjh2VXU4cDVi?=
 =?utf-8?B?Q0FXeVdvSWVlTFpzeXRJcER5WVpUTXRmMFU5UlN6TmUzVVNyWmplVnUvUlN6?=
 =?utf-8?B?cTlYdkZoTEdQZ2lXaldDbmVzYmRqU0luWjRibFJ3MkpYZ2FmOWRKRkVJZlFv?=
 =?utf-8?B?WVVoTGdJTm5CWDRtRjA0bzVYbG5zTGZhR0xpOHMrUGNZVlFVek4zVHQ3VXVV?=
 =?utf-8?Q?mYWcrbEVYGZVkCNI4oQKtmG77luMdLzjl0?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 15:40:03.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-Network-Message-Id: 531609d7-4d55-4aca-75f3-08d8a75903f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY0HAqEbDJSy+jhSCRgYs9rf3QjRf4XCC3HE8vmcuzq+0DR59Lj3+iMXq6daxBx92HpDAPArycogkEJyO+jnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaHdpby5jIHwgMzQwICsrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaHdp
by5oIHwgIDc5ICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0MTkgaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaHdpby5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9od2lvLmgK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2h3aW8uYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaHdpby5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwMC4uMzkzYmNiMWUyZjRlCi0tLSAvZGV2L251bGwKKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9od2lvLmMKQEAgLTAsMCArMSwzNDAgQEAKKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBMb3ctbGV2ZWwg
SS9PIGZ1bmN0aW9ucy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNvbiBM
YWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAq
LworI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Cisj
aW5jbHVkZSA8bGludXgvc2xhYi5oPgorCisjaW5jbHVkZSAiaHdpby5oIgorI2luY2x1ZGUgIndm
eC5oIgorI2luY2x1ZGUgImJ1cy5oIgorI2luY2x1ZGUgInRyYWNlcy5oIgorCitzdGF0aWMgaW50
IHJlYWQzMihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHJlZywgdTMyICp2YWwpCit7CisJaW50
IHJldDsKKwlfX2xlMzIgKnRtcCA9IGttYWxsb2Moc2l6ZW9mKHUzMiksIEdGUF9LRVJORUwpOwor
CisJKnZhbCA9IH4wOyAvKiBOZXZlciByZXR1cm4gdW5kZWZpbmVkIHZhbHVlICovCisJaWYgKCF0
bXApCisJCXJldHVybiAtRU5PTUVNOworCXJldCA9IHdkZXYtPmh3YnVzX29wcy0+Y29weV9mcm9t
X2lvKHdkZXYtPmh3YnVzX3ByaXYsIHJlZywgdG1wLAorCQkJCQkgICAgc2l6ZW9mKHUzMikpOwor
CWlmIChyZXQgPj0gMCkKKwkJKnZhbCA9IGxlMzJfdG9fY3B1KCp0bXApOworCWtmcmVlKHRtcCk7
CisJaWYgKHJldCkKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICIlczogYnVzIGNvbW11bmljYXRpb24g
ZXJyb3I6ICVkXG4iLAorCQkJX19mdW5jX18sIHJldCk7CisJcmV0dXJuIHJldDsKK30KKworc3Rh
dGljIGludCB3cml0ZTMyKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIgdmFsKQor
eworCWludCByZXQ7CisJX19sZTMyICp0bXAgPSBrbWFsbG9jKHNpemVvZih1MzIpLCBHRlBfS0VS
TkVMKTsKKworCWlmICghdG1wKQorCQlyZXR1cm4gLUVOT01FTTsKKwkqdG1wID0gY3B1X3RvX2xl
MzIodmFsKTsKKwlyZXQgPSB3ZGV2LT5od2J1c19vcHMtPmNvcHlfdG9faW8od2Rldi0+aHdidXNf
cHJpdiwgcmVnLCB0bXAsCisJCQkJCSAgc2l6ZW9mKHUzMikpOworCWtmcmVlKHRtcCk7CisJaWYg
KHJldCkKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICIlczogYnVzIGNvbW11bmljYXRpb24gZXJyb3I6
ICVkXG4iLAorCQkJX19mdW5jX18sIHJldCk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlu
dCByZWFkMzJfbG9ja2VkKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIgKnZhbCkK
K3sKKwlpbnQgcmV0OworCisJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYp
OworCXJldCA9IHJlYWQzMih3ZGV2LCByZWcsIHZhbCk7CisJX3RyYWNlX2lvX3JlYWQzMihyZWcs
ICp2YWwpOworCXdkZXYtPmh3YnVzX29wcy0+dW5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOworCXJl
dHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgd3JpdGUzMl9sb2NrZWQoc3RydWN0IHdmeF9kZXYg
KndkZXYsIGludCByZWcsIHUzMiB2YWwpCit7CisJaW50IHJldDsKKworCXdkZXYtPmh3YnVzX29w
cy0+bG9jayh3ZGV2LT5od2J1c19wcml2KTsKKwlyZXQgPSB3cml0ZTMyKHdkZXYsIHJlZywgdmFs
KTsKKwlfdHJhY2VfaW9fd3JpdGUzMihyZWcsIHZhbCk7CisJd2Rldi0+aHdidXNfb3BzLT51bmxv
Y2sod2Rldi0+aHdidXNfcHJpdik7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCB3cml0
ZTMyX2JpdHNfbG9ja2VkKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIgbWFzaywg
dTMyIHZhbCkKK3sKKwlpbnQgcmV0OworCXUzMiB2YWxfciwgdmFsX3c7CisKKwlXQVJOX09OKH5t
YXNrICYgdmFsKTsKKwl2YWwgJj0gbWFzazsKKwl3ZGV2LT5od2J1c19vcHMtPmxvY2sod2Rldi0+
aHdidXNfcHJpdik7CisJcmV0ID0gcmVhZDMyKHdkZXYsIHJlZywgJnZhbF9yKTsKKwlfdHJhY2Vf
aW9fcmVhZDMyKHJlZywgdmFsX3IpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIGVycjsKKwl2YWxf
dyA9ICh2YWxfciAmIH5tYXNrKSB8IHZhbDsKKwlpZiAodmFsX3cgIT0gdmFsX3IpIHsKKwkJcmV0
ID0gd3JpdGUzMih3ZGV2LCByZWcsIHZhbF93KTsKKwkJX3RyYWNlX2lvX3dyaXRlMzIocmVnLCB2
YWxfdyk7CisJfQorZXJyOgorCXdkZXYtPmh3YnVzX29wcy0+dW5sb2NrKHdkZXYtPmh3YnVzX3By
aXYpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgaW5kaXJlY3RfcmVhZChzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwgaW50IHJlZywgdTMyIGFkZHIsCisJCQkgdm9pZCAqYnVmLCBzaXplX3Qg
bGVuKQoreworCWludCByZXQ7CisJaW50IGk7CisJdTMyIGNmZzsKKwl1MzIgcHJlZmV0Y2g7CisK
KwlXQVJOX09OKGxlbiA+PSAweDIwMDApOworCVdBUk5fT04ocmVnICE9IFdGWF9SRUdfQUhCX0RQ
T1JUICYmIHJlZyAhPSBXRlhfUkVHX1NSQU1fRFBPUlQpOworCisJaWYgKHJlZyA9PSBXRlhfUkVH
X0FIQl9EUE9SVCkKKwkJcHJlZmV0Y2ggPSBDRkdfUFJFRkVUQ0hfQUhCOworCWVsc2UgaWYgKHJl
ZyA9PSBXRlhfUkVHX1NSQU1fRFBPUlQpCisJCXByZWZldGNoID0gQ0ZHX1BSRUZFVENIX1NSQU07
CisJZWxzZQorCQlyZXR1cm4gLUVOT0RFVjsKKworCXJldCA9IHdyaXRlMzIod2RldiwgV0ZYX1JF
R19CQVNFX0FERFIsIGFkZHIpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIGVycjsKKworCXJldCA9
IHJlYWQzMih3ZGV2LCBXRlhfUkVHX0NPTkZJRywgJmNmZyk7CisJaWYgKHJldCA8IDApCisJCWdv
dG8gZXJyOworCisJcmV0ID0gd3JpdGUzMih3ZGV2LCBXRlhfUkVHX0NPTkZJRywgY2ZnIHwgcHJl
ZmV0Y2gpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIGVycjsKKworCWZvciAoaSA9IDA7IGkgPCAy
MDsgaSsrKSB7CisJCXJldCA9IHJlYWQzMih3ZGV2LCBXRlhfUkVHX0NPTkZJRywgJmNmZyk7CisJ
CWlmIChyZXQgPCAwKQorCQkJZ290byBlcnI7CisJCWlmICghKGNmZyAmIHByZWZldGNoKSkKKwkJ
CWJyZWFrOworCQl1c2xlZXBfcmFuZ2UoMjAwLCAyNTApOworCX0KKwlpZiAoaSA9PSAyMCkgewor
CQlyZXQgPSAtRVRJTUVET1VUOworCQlnb3RvIGVycjsKKwl9CisKKwlyZXQgPSB3ZGV2LT5od2J1
c19vcHMtPmNvcHlfZnJvbV9pbyh3ZGV2LT5od2J1c19wcml2LCByZWcsIGJ1ZiwgbGVuKTsKKwor
ZXJyOgorCWlmIChyZXQgPCAwKQorCQltZW1zZXQoYnVmLCAweEZGLCBsZW4pOyAvKiBOZXZlciBy
ZXR1cm4gdW5kZWZpbmVkIHZhbHVlICovCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBp
bmRpcmVjdF93cml0ZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHJlZywgdTMyIGFkZHIsCisJ
CQkgIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikKK3sKKwlpbnQgcmV0OworCisJV0FSTl9P
TihsZW4gPj0gMHgyMDAwKTsKKwlXQVJOX09OKHJlZyAhPSBXRlhfUkVHX0FIQl9EUE9SVCAmJiBy
ZWcgIT0gV0ZYX1JFR19TUkFNX0RQT1JUKTsKKwlyZXQgPSB3cml0ZTMyKHdkZXYsIFdGWF9SRUdf
QkFTRV9BRERSLCBhZGRyKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKworCXJldHVy
biB3ZGV2LT5od2J1c19vcHMtPmNvcHlfdG9faW8od2Rldi0+aHdidXNfcHJpdiwgcmVnLCBidWYs
IGxlbik7Cit9CisKK3N0YXRpYyBpbnQgaW5kaXJlY3RfcmVhZF9sb2NrZWQoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIGludCByZWcsIHUzMiBhZGRyLAorCQkJCXZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikK
K3sKKwlpbnQgcmV0OworCisJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYp
OworCXJldCA9IGluZGlyZWN0X3JlYWQod2RldiwgcmVnLCBhZGRyLCBidWYsIGxlbik7CisJX3Ry
YWNlX2lvX2luZF9yZWFkKHJlZywgYWRkciwgYnVmLCBsZW4pOworCXdkZXYtPmh3YnVzX29wcy0+
dW5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQg
aW5kaXJlY3Rfd3JpdGVfbG9ja2VkKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIg
YWRkciwKKwkJCQkgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQoreworCWludCByZXQ7CisK
Kwl3ZGV2LT5od2J1c19vcHMtPmxvY2sod2Rldi0+aHdidXNfcHJpdik7CisJcmV0ID0gaW5kaXJl
Y3Rfd3JpdGUod2RldiwgcmVnLCBhZGRyLCBidWYsIGxlbik7CisJX3RyYWNlX2lvX2luZF93cml0
ZShyZWcsIGFkZHIsIGJ1ZiwgbGVuKTsKKwl3ZGV2LT5od2J1c19vcHMtPnVubG9jayh3ZGV2LT5o
d2J1c19wcml2KTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IGluZGlyZWN0X3JlYWQz
Ml9sb2NrZWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCByZWcsCisJCQkJICB1MzIgYWRkciwg
dTMyICp2YWwpCit7CisJaW50IHJldDsKKwlfX2xlMzIgKnRtcCA9IGttYWxsb2Moc2l6ZW9mKHUz
MiksIEdGUF9LRVJORUwpOworCisJaWYgKCF0bXApCisJCXJldHVybiAtRU5PTUVNOworCXdkZXYt
Pmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1c19wcml2KTsKKwlyZXQgPSBpbmRpcmVjdF9yZWFk
KHdkZXYsIHJlZywgYWRkciwgdG1wLCBzaXplb2YodTMyKSk7CisJKnZhbCA9IGxlMzJfdG9fY3B1
KCp0bXApOworCV90cmFjZV9pb19pbmRfcmVhZDMyKHJlZywgYWRkciwgKnZhbCk7CisJd2Rldi0+
aHdidXNfb3BzLT51bmxvY2sod2Rldi0+aHdidXNfcHJpdik7CisJa2ZyZWUodG1wKTsKKwlyZXR1
cm4gcmV0OworfQorCitzdGF0aWMgaW50IGluZGlyZWN0X3dyaXRlMzJfbG9ja2VkKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLAorCQkJCSAgIHUzMiBhZGRyLCB1MzIgdmFsKQoreworCWlu
dCByZXQ7CisJX19sZTMyICp0bXAgPSBrbWFsbG9jKHNpemVvZih1MzIpLCBHRlBfS0VSTkVMKTsK
KworCWlmICghdG1wKQorCQlyZXR1cm4gLUVOT01FTTsKKwkqdG1wID0gY3B1X3RvX2xlMzIodmFs
KTsKKwl3ZGV2LT5od2J1c19vcHMtPmxvY2sod2Rldi0+aHdidXNfcHJpdik7CisJcmV0ID0gaW5k
aXJlY3Rfd3JpdGUod2RldiwgcmVnLCBhZGRyLCB0bXAsIHNpemVvZih1MzIpKTsKKwlfdHJhY2Vf
aW9faW5kX3dyaXRlMzIocmVnLCBhZGRyLCB2YWwpOworCXdkZXYtPmh3YnVzX29wcy0+dW5sb2Nr
KHdkZXYtPmh3YnVzX3ByaXYpOworCWtmcmVlKHRtcCk7CisJcmV0dXJuIHJldDsKK30KKworaW50
IHdmeF9kYXRhX3JlYWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxl
bikKK3sKKwlpbnQgcmV0OworCisJV0FSTigobG9uZylidWYgJiAzLCAiJXM6IHVuYWxpZ25lZCBi
dWZmZXIiLCBfX2Z1bmNfXyk7CisJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3By
aXYpOworCXJldCA9IHdkZXYtPmh3YnVzX29wcy0+Y29weV9mcm9tX2lvKHdkZXYtPmh3YnVzX3By
aXYsCisJCQkJCSAgICBXRlhfUkVHX0lOX09VVF9RVUVVRSwgYnVmLCBsZW4pOworCV90cmFjZV9p
b19yZWFkKFdGWF9SRUdfSU5fT1VUX1FVRVVFLCBidWYsIGxlbik7CisJd2Rldi0+aHdidXNfb3Bz
LT51bmxvY2sod2Rldi0+aHdidXNfcHJpdik7CisJaWYgKHJldCkKKwkJZGV2X2Vycih3ZGV2LT5k
ZXYsICIlczogYnVzIGNvbW11bmljYXRpb24gZXJyb3I6ICVkXG4iLAorCQkJX19mdW5jX18sIHJl
dCk7CisJcmV0dXJuIHJldDsKK30KKworaW50IHdmeF9kYXRhX3dyaXRlKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBsZW4pCit7CisJaW50IHJldDsKKworCVdB
Uk4oKGxvbmcpYnVmICYgMywgIiVzOiB1bmFsaWduZWQgYnVmZmVyIiwgX19mdW5jX18pOworCXdk
ZXYtPmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1c19wcml2KTsKKwlyZXQgPSB3ZGV2LT5od2J1
c19vcHMtPmNvcHlfdG9faW8od2Rldi0+aHdidXNfcHJpdiwKKwkJCQkJICBXRlhfUkVHX0lOX09V
VF9RVUVVRSwgYnVmLCBsZW4pOworCV90cmFjZV9pb193cml0ZShXRlhfUkVHX0lOX09VVF9RVUVV
RSwgYnVmLCBsZW4pOworCXdkZXYtPmh3YnVzX29wcy0+dW5sb2NrKHdkZXYtPmh3YnVzX3ByaXYp
OworCWlmIChyZXQpCisJCWRldl9lcnIod2Rldi0+ZGV2LCAiJXM6IGJ1cyBjb21tdW5pY2F0aW9u
IGVycm9yOiAlZFxuIiwKKwkJCV9fZnVuY19fLCByZXQpOworCXJldHVybiByZXQ7Cit9CisKK2lu
dCBzcmFtX2J1Zl9yZWFkKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgYWRkciwgdm9pZCAqYnVm
LCBzaXplX3QgbGVuKQoreworCXJldHVybiBpbmRpcmVjdF9yZWFkX2xvY2tlZCh3ZGV2LCBXRlhf
UkVHX1NSQU1fRFBPUlQsIGFkZHIsIGJ1ZiwgbGVuKTsKK30KKworaW50IGFoYl9idWZfcmVhZChz
dHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyIGFkZHIsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikKK3sK
KwlyZXR1cm4gaW5kaXJlY3RfcmVhZF9sb2NrZWQod2RldiwgV0ZYX1JFR19BSEJfRFBPUlQsIGFk
ZHIsIGJ1ZiwgbGVuKTsKK30KKworaW50IHNyYW1fYnVmX3dyaXRlKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2LCB1MzIgYWRkciwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQoreworCXJldHVybiBp
bmRpcmVjdF93cml0ZV9sb2NrZWQod2RldiwgV0ZYX1JFR19TUkFNX0RQT1JULCBhZGRyLCBidWYs
IGxlbik7Cit9CisKK2ludCBhaGJfYnVmX3dyaXRlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIg
YWRkciwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQoreworCXJldHVybiBpbmRpcmVjdF93
cml0ZV9sb2NrZWQod2RldiwgV0ZYX1JFR19BSEJfRFBPUlQsIGFkZHIsIGJ1ZiwgbGVuKTsKK30K
KworaW50IHNyYW1fcmVnX3JlYWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBhZGRyLCB1MzIg
KnZhbCkKK3sKKwlyZXR1cm4gaW5kaXJlY3RfcmVhZDMyX2xvY2tlZCh3ZGV2LCBXRlhfUkVHX1NS
QU1fRFBPUlQsIGFkZHIsIHZhbCk7Cit9CisKK2ludCBhaGJfcmVnX3JlYWQoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHUzMiBhZGRyLCB1MzIgKnZhbCkKK3sKKwlyZXR1cm4gaW5kaXJlY3RfcmVhZDMy
X2xvY2tlZCh3ZGV2LCBXRlhfUkVHX0FIQl9EUE9SVCwgYWRkciwgdmFsKTsKK30KKworaW50IHNy
YW1fcmVnX3dyaXRlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgYWRkciwgdTMyIHZhbCkKK3sK
KwlyZXR1cm4gaW5kaXJlY3Rfd3JpdGUzMl9sb2NrZWQod2RldiwgV0ZYX1JFR19TUkFNX0RQT1JU
LCBhZGRyLCB2YWwpOworfQorCitpbnQgYWhiX3JlZ193cml0ZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwgdTMyIGFkZHIsIHUzMiB2YWwpCit7CisJcmV0dXJuIGluZGlyZWN0X3dyaXRlMzJfbG9ja2Vk
KHdkZXYsIFdGWF9SRUdfQUhCX0RQT1JULCBhZGRyLCB2YWwpOworfQorCitpbnQgY29uZmlnX3Jl
Z19yZWFkKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgKnZhbCkKK3sKKwlyZXR1cm4gcmVhZDMy
X2xvY2tlZCh3ZGV2LCBXRlhfUkVHX0NPTkZJRywgdmFsKTsKK30KKworaW50IGNvbmZpZ19yZWdf
d3JpdGUoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiB2YWwpCit7CisJcmV0dXJuIHdyaXRlMzJf
bG9ja2VkKHdkZXYsIFdGWF9SRUdfQ09ORklHLCB2YWwpOworfQorCitpbnQgY29uZmlnX3JlZ193
cml0ZV9iaXRzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgbWFzaywgdTMyIHZhbCkKK3sKKwly
ZXR1cm4gd3JpdGUzMl9iaXRzX2xvY2tlZCh3ZGV2LCBXRlhfUkVHX0NPTkZJRywgbWFzaywgdmFs
KTsKK30KKworaW50IGNvbnRyb2xfcmVnX3JlYWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiAq
dmFsKQoreworCXJldHVybiByZWFkMzJfbG9ja2VkKHdkZXYsIFdGWF9SRUdfQ09OVFJPTCwgdmFs
KTsKK30KKworaW50IGNvbnRyb2xfcmVnX3dyaXRlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIg
dmFsKQoreworCXJldHVybiB3cml0ZTMyX2xvY2tlZCh3ZGV2LCBXRlhfUkVHX0NPTlRST0wsIHZh
bCk7Cit9CisKK2ludCBjb250cm9sX3JlZ193cml0ZV9iaXRzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
LCB1MzIgbWFzaywgdTMyIHZhbCkKK3sKKwlyZXR1cm4gd3JpdGUzMl9iaXRzX2xvY2tlZCh3ZGV2
LCBXRlhfUkVHX0NPTlRST0wsIG1hc2ssIHZhbCk7Cit9CisKK2ludCBpZ3ByX3JlZ19yZWFkKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgaW5kZXgsIHUzMiAqdmFsKQoreworCWludCByZXQ7CisK
KwkqdmFsID0gfjA7IC8qIE5ldmVyIHJldHVybiB1bmRlZmluZWQgdmFsdWUgKi8KKwlyZXQgPSB3
cml0ZTMyX2xvY2tlZCh3ZGV2LCBXRlhfUkVHX1NFVF9HRU5fUl9XLCBJR1BSX1JXIHwgaW5kZXgg
PDwgMjQpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisJcmV0ID0gcmVhZDMyX2xvY2tlZCh3
ZGV2LCBXRlhfUkVHX1NFVF9HRU5fUl9XLCB2YWwpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7
CisJKnZhbCAmPSBJR1BSX1ZBTFVFOworCXJldHVybiByZXQ7Cit9CisKK2ludCBpZ3ByX3JlZ193
cml0ZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IGluZGV4LCB1MzIgdmFsKQoreworCXJldHVy
biB3cml0ZTMyX2xvY2tlZCh3ZGV2LCBXRlhfUkVHX1NFVF9HRU5fUl9XLCBpbmRleCA8PCAyNCB8
IHZhbCk7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2h3
aW8uaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaHdpby5oCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMjBiMWQ3YTZhN2RlCi0tLSAvZGV2L251bGwK
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9od2lvLmgKQEAgLTAsMCArMSw3
OSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLworLyoKKyAq
IExvdy1sZXZlbCBBUEkuCisgKgorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMjAsIFNpbGljb24g
TGFib3JhdG9yaWVzLCBJbmMuCisgKiBDb3B5cmlnaHQgKGMpIDIwMTAsIFNULUVyaWNzc29uCisg
Ki8KKyNpZm5kZWYgV0ZYX0hXSU9fSAorI2RlZmluZSBXRlhfSFdJT19ICisKKyNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPgorCitzdHJ1Y3Qgd2Z4X2RldjsKKworLyogQ2F1dGlvbjogaW4gdGhlIGZ1
bmN0aW9ucyBiZWxvdywgJ2J1Zicgd2lsbCB1c2VkIHdpdGggYSBETUEuIFNvLCBpdCBtdXN0IGJl
CisgKiBrbWFsbG9jJ2QgKGRvIG5vdCB1c2Ugc3RhY2sgYWxsb2NhdGVkIGJ1ZmZlcnMpLiBJbiBk
b3VidCwgZW5hYmxlCisgKiBDT05GSUdfREVCVUdfU0cgdG8gZGV0ZWN0IGJhZGx5IGxvY2F0ZWQg
YnVmZmVyLgorICovCitpbnQgd2Z4X2RhdGFfcmVhZChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgdm9p
ZCAqYnVmLCBzaXplX3QgYnVmX2xlbik7CitpbnQgd2Z4X2RhdGFfd3JpdGUoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4pOworCitpbnQgc3JhbV9i
dWZfcmVhZChzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyIGFkZHIsIHZvaWQgKmJ1Ziwgc2l6ZV90
IGxlbik7CitpbnQgc3JhbV9idWZfd3JpdGUoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBhZGRy
LCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBsZW4pOworCitpbnQgYWhiX2J1Zl9yZWFkKHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCB1MzIgYWRkciwgdm9pZCAqYnVmLCBzaXplX3QgbGVuKTsKK2ludCBh
aGJfYnVmX3dyaXRlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgYWRkciwgY29uc3Qgdm9pZCAq
YnVmLCBzaXplX3QgbGVuKTsKKworaW50IHNyYW1fcmVnX3JlYWQoc3RydWN0IHdmeF9kZXYgKndk
ZXYsIHUzMiBhZGRyLCB1MzIgKnZhbCk7CitpbnQgc3JhbV9yZWdfd3JpdGUoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHUzMiBhZGRyLCB1MzIgdmFsKTsKKworaW50IGFoYl9yZWdfcmVhZChzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwgdTMyIGFkZHIsIHUzMiAqdmFsKTsKK2ludCBhaGJfcmVnX3dyaXRlKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgYWRkciwgdTMyIHZhbCk7CisKKyNkZWZpbmUgQ0ZHX0VS
Ul9TUElfRlJBTUUgICAgICAgICAgMHgwMDAwMDAwMSAvKiBvbmx5IHdpdGggU1BJICovCisjZGVm
aW5lIENGR19FUlJfU0RJT19CVUZfTUlTTUFUQ0ggIDB4MDAwMDAwMDEgLyogb25seSB3aXRoIFNE
SU8gKi8KKyNkZWZpbmUgQ0ZHX0VSUl9CVUZfVU5ERVJSVU4gICAgICAgMHgwMDAwMDAwMgorI2Rl
ZmluZSBDRkdfRVJSX0RBVEFfSU5fVE9PX0xBUkdFICAweDAwMDAwMDA0CisjZGVmaW5lIENGR19F
UlJfSE9TVF9OT19PVVRfUVVFVUUgIDB4MDAwMDAwMDgKKyNkZWZpbmUgQ0ZHX0VSUl9CVUZfT1ZF
UlJVTiAgICAgICAgMHgwMDAwMDAxMAorI2RlZmluZSBDRkdfRVJSX0RBVEFfT1VUX1RPT19MQVJH
RSAweDAwMDAwMDIwCisjZGVmaW5lIENGR19FUlJfSE9TVF9OT19JTl9RVUVVRSAgIDB4MDAwMDAw
NDAKKyNkZWZpbmUgQ0ZHX0VSUl9IT1NUX0NSQ19NSVNTICAgICAgMHgwMDAwMDA4MCAvKiBvbmx5
IHdpdGggU0RJTyAqLworI2RlZmluZSBDRkdfU1BJX0lHTk9SRV9DUyAgICAgICAgICAweDAwMDAw
MDgwIC8qIG9ubHkgd2l0aCBTUEkgKi8KKyNkZWZpbmUgQ0ZHX0JZVEVfT1JERVJfTUFTSyAgICAg
ICAgMHgwMDAwMDMwMCAvKiBvbmx5IHdyaXRhYmxlIHdpdGggU1BJICovCisjZGVmaW5lICAgICBD
RkdfQllURV9PUkRFUl9CQURDICAgIDB4MDAwMDAwMDAKKyNkZWZpbmUgICAgIENGR19CWVRFX09S
REVSX0RDQkEgICAgMHgwMDAwMDEwMAorI2RlZmluZSAgICAgQ0ZHX0JZVEVfT1JERVJfQUJDRCAg
ICAweDAwMDAwMjAwIC8qIFNESU8gYWx3YXlzIHVzZSB0aGlzIHZhbHVlICovCisjZGVmaW5lIENG
R19ESVJFQ1RfQUNDRVNTX01PREUgICAgIDB4MDAwMDA0MDAKKyNkZWZpbmUgQ0ZHX1BSRUZFVENI
X0FIQiAgICAgICAgICAgMHgwMDAwMDgwMAorI2RlZmluZSBDRkdfRElTQUJMRV9DUFVfQ0xLICAg
ICAgICAweDAwMDAxMDAwCisjZGVmaW5lIENGR19QUkVGRVRDSF9TUkFNICAgICAgICAgIDB4MDAw
MDIwMDAKKyNkZWZpbmUgQ0ZHX0NQVV9SRVNFVCAgICAgICAgICAgICAgMHgwMDAwNDAwMAorI2Rl
ZmluZSBDRkdfU0RJT19ESVNBQkxFX0lSUSAgICAgICAweDAwMDA4MDAwIC8qIG9ubHkgd2l0aCBT
RElPICovCisjZGVmaW5lIENGR19JUlFfRU5BQkxFX0RBVEEgICAgICAgIDB4MDAwMTAwMDAKKyNk
ZWZpbmUgQ0ZHX0lSUV9FTkFCTEVfV1JEWSAgICAgICAgMHgwMDAyMDAwMAorI2RlZmluZSBDRkdf
Q0xLX1JJU0VfRURHRSAgICAgICAgICAweDAwMDQwMDAwCisjZGVmaW5lIENGR19TRElPX0RJU0FC
TEVfQ1JDX0NISyAgIDB4MDAwODAwMDAgLyogb25seSB3aXRoIFNESU8gKi8KKyNkZWZpbmUgQ0ZH
X1JFU0VSVkVEICAgICAgICAgICAgICAgMHgwMEYwMDAwMAorI2RlZmluZSBDRkdfREVWSUNFX0lE
X01BSk9SICAgICAgICAweDA3MDAwMDAwCisjZGVmaW5lIENGR19ERVZJQ0VfSURfUkVTRVJWRUQg
ICAgIDB4NzgwMDAwMDAKKyNkZWZpbmUgQ0ZHX0RFVklDRV9JRF9UWVBFICAgICAgICAgMHg4MDAw
MDAwMAoraW50IGNvbmZpZ19yZWdfcmVhZChzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyICp2YWwp
OworaW50IGNvbmZpZ19yZWdfd3JpdGUoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiB2YWwpOwor
aW50IGNvbmZpZ19yZWdfd3JpdGVfYml0cyhzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyIG1hc2ss
IHUzMiB2YWwpOworCisjZGVmaW5lIENUUkxfTkVYVF9MRU5fTUFTSyAgIDB4MDAwMDBGRkYKKyNk
ZWZpbmUgQ1RSTF9XTEFOX1dBS0VVUCAgICAgMHgwMDAwMTAwMAorI2RlZmluZSBDVFJMX1dMQU5f
UkVBRFkgICAgICAweDAwMDAyMDAwCitpbnQgY29udHJvbF9yZWdfcmVhZChzdHJ1Y3Qgd2Z4X2Rl
diAqd2RldiwgdTMyICp2YWwpOworaW50IGNvbnRyb2xfcmVnX3dyaXRlKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LCB1MzIgdmFsKTsKK2ludCBjb250cm9sX3JlZ193cml0ZV9iaXRzKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2LCB1MzIgbWFzaywgdTMyIHZhbCk7CisKKyNkZWZpbmUgSUdQUl9SVyAgICAgICAg
ICAweDgwMDAwMDAwCisjZGVmaW5lIElHUFJfSU5ERVggICAgICAgMHg3RjAwMDAwMAorI2RlZmlu
ZSBJR1BSX1ZBTFVFICAgICAgIDB4MDBGRkZGRkYKK2ludCBpZ3ByX3JlZ19yZWFkKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2LCBpbnQgaW5kZXgsIHUzMiAqdmFsKTsKK2ludCBpZ3ByX3JlZ193cml0ZShz
dHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IGluZGV4LCB1MzIgdmFsKTsKKworI2VuZGlmCi0tIAoy
LjI5LjIKCg==

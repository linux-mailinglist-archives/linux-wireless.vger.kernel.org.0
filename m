Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB433B3F3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCON0L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 09:26:11 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:60257
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229506AbhCONZh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 09:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqIEQyPBI0ChOmAY1Au+TJIc56cd2di8PpaPEINu03Kl7HL30KiWwHokO1uB7DLSvtABKAIfrOg7jQU2gdjxoQTgi7X2YN6ilcdLFdrt5kSSIZ32gupNf47L2OF5xuZJnrLjfy+mzvo4mi46cJUO3aIRnX5GqDYSZQSkQmrYHihN6jLme9CCYIHqFZwO7nrbMHKsF8yHfM3ZGbud6zVjDF2Y41F7aA5UcvUY2hI15rlIReErtR9IgMjQ/WG4oHuxSN/3igsY96HPN7EJsr/fxT9ksRO9IC0DSQsFMKMOXZNm/Ows+7k0mNEb8gvl5BNES+oIhG/lDa+sNCKXVv6H4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8WC8zAlBc+Dsn1EMSLYwI+1Ox5dZ5wxVtA7cOhjgQw=;
 b=gh3/j9vB8PW36vP4PRrWUTguh2pDaoAW+fVmpLBJusqgMLr54u7n2lCeu1TmMqqyUab7fcdTAaQZrwuyHyO/ih8fqX7laRGFlpnfLNNv8BOSbx0n6ho0T3tBxqGiVHH2VdpS49p0T0WiT8KUdPe+vs24DeTxUHM//ahjms4c/OxB2VuvZ5ySiz69LSmQecxOGCrEkWtsDDoxgTwKqcaaXiOPox1bREISJEC9DKOvmGslSAcln40/9vdmHlMCCLoD4SF9+AcSbuRpQEbWCbrUAW5dX91684NReRg+zikyzpd1Qz4n8mNdVttUcXAD8eNDXI5En+IG5fiXoP1D4ZVYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8WC8zAlBc+Dsn1EMSLYwI+1Ox5dZ5wxVtA7cOhjgQw=;
 b=aogpuS1cqKBIAinzNpoys0kUOv/DPsZHL3vlEceoDG5QftlwI4mvawKbONEHJeeX/DzjcMpsRck7GPIt91/WbCRBH37IJJ1S6jxqrU3dvtpmpCF7y/nfUlhi1UtJ2VKUWgytelrkTP6hg4VFRIPKhH3+rO/6us0SvLS2kw7XEBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA2PR11MB5099.namprd11.prod.outlook.com (2603:10b6:806:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 13:25:36 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 13:25:36 +0000
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
Subject: [PATCH v5 05/24] wfx: add main.c/main.h
Date:   Mon, 15 Mar 2021 14:24:42 +0100
Message-Id: <20210315132501.441681-6-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315132501.441681-1-Jerome.Pouiller@silabs.com>
References: <20210315132501.441681-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-ClientProxiedBy: SN4PR0801CA0014.namprd08.prod.outlook.com
 (2603:10b6:803:29::24) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by SN4PR0801CA0014.namprd08.prod.outlook.com (2603:10b6:803:29::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 13:25:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f367e137-825f-49c3-29d7-08d8e7b5d159
X-MS-TrafficTypeDiagnostic: SA2PR11MB5099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB50996E3CC7EB9A25D3582E9D936C9@SA2PR11MB5099.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AEaxRxOfmiPNdKNK4e9eC6q52sVV4SbDMym2YGHfAKWC0sQRln9CpIcnHazH70X1I9OUkhGOj3c2P/MCmLEbSc+b6m6+CSp7m6Uz7fcJt9t6a5TSyL7XplwIOdo2v2lRwaBu6UmuF0ldeGHDCV+9QYfMCpf6fZbd3A+OYQGVholtoJW7nyZtUehorRkxFPdFoPp723glXdHeGsmATcTk5rQajS/SK9si8q2bcCx4/CEEDKYArUqHxxE1Wpx5Qf3Fr9yCgEcFmsu2CJeRGeoOUo0UqXmyF7gqM3cEa+URWQX5HAoCQWT8XY5wSPrsfQnO9kew+Q+KDrva6owMSSrIuZ+OSh3O/ux4O5lbzcaZ0nQDTyPEEsefwBYzf9aoTg2lvo5Xr9Abfep3m7JZGxbtwhqW3a5DBR0tS/83WUtPBQrx+dMqCoygFmCUuU2cqDmtOnbXawBEUO0i25rUTeS/8rZVXxo9tnbiEfIvAtOxohAqHsh7rFwIPjI0YZSBb8hdIoaSlWLvONtnavR6umkKyASwzsPC+BSZChzUusYkRUHlPo+eGBWqkYgva25YXM1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39850400004)(376002)(366004)(186003)(7416002)(2616005)(107886003)(4326008)(478600001)(83380400001)(16526019)(66476007)(86362001)(66946007)(54906003)(66556008)(8936002)(30864003)(316002)(5660300002)(66574015)(8676002)(1076003)(52116002)(7696005)(6666004)(36756003)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a2Q5OEMvSVF3ck12ekQxTWxlSUFuY1BkR2VsSS9oT0o1VkN2VXJ3Q0xTRU4z?=
 =?utf-8?B?bFM4bDREcjhsdEdyUHlwUmd3RFZQYWcvUG4xdURSN1pwNm03d3BMbDZWNDkz?=
 =?utf-8?B?SktLVFZEKzVNZFBQUkZmRjVhcnBPZ0RQOXZWVjZDYVhYYm1CVXo2WFczTFdu?=
 =?utf-8?B?WTBpQjVmbTVNaHNxMWpsZVF0c0hLTUJrcm9kcktpZ2dFMWtNdUtXRlFGNTRL?=
 =?utf-8?B?eG9oRzF4MlJ5ZU95WUMxQUJub2xneVMrMmJnMTV0cnBKWDZlS2NVV25IT2dY?=
 =?utf-8?B?NHRET3d0Wm1tZHN1VHRkMTd2bU1jcGFNcVgzNEN2V2sxQkI0MkNESU80d015?=
 =?utf-8?B?WWYweXlqRGttV0lZaGVGdWtqbmZWbjd2MFZrL2Q1NFZkZ0lUaXUvaWh4K2tU?=
 =?utf-8?B?V002NHRyYUJLTlMvc0lBRi9DTEF4Wk56UDBlWjdESm1aYjFEZFlnUkRhY0wz?=
 =?utf-8?B?bG1XUVduYTFHOUpNSzA5c2lUeThkWXhPZWJYWmMvYlYvUkVrR2N0cU4welF0?=
 =?utf-8?B?OXFhcnUxQ3Z1KzcvYnRjV3hLU3dxYXhVNk1aQTBKOUdDSndOek9BNVdKbHM4?=
 =?utf-8?B?N3h4b25mdW5CQ3lEYWZtMTZKWE0weDZLM3hKQVppWXVjemk0ZjFUcmdWMFU4?=
 =?utf-8?B?eXZ2QmM0cUtHRk4xTzlZcmJQOTd4REJ4MjFHOVhvMXNMdysxaG5Ia2J2MmZp?=
 =?utf-8?B?VXQxajhSd015WUo4dm42L2lIMWZBek02bFZMcllMajNJeXBiZitOckNuOXdk?=
 =?utf-8?B?U0tERjhRV1ZGUWdOM2R4RnlFMmQ1RUFQVmNoNEpaYXg2dzlSVkE2YldTMGl3?=
 =?utf-8?B?ZDFFV0RBSzljNVhLbGM3YUVqRlRBaWNMTVR5UGpuUUo0MHpaT0N5Zkt1ZERy?=
 =?utf-8?B?QmJxUzFZQzM3WnAyWUh5Mk1RK1VPR2c0enoxSlRLcmoxU01rY0hHWUJwK1dn?=
 =?utf-8?B?VEdnNjMvZTRuUjl1VFpsRWJuVTR4MlFOZnIzZzdMY0RqUWFtOFNkSGFaUWRk?=
 =?utf-8?B?Mmd0UGJ4WCttVjJiTkRVUWU0b2JQODAyVEFHNC9NblJVTTRKaUpMN0Zrd2hE?=
 =?utf-8?B?dWFJQkFkcGF5eGJLTTN0UGl4aDN5anAyQ3B5dGtONm5mbGp2Ykltdm1HVER3?=
 =?utf-8?B?TUhVYld2bmJiMnExT1JDbXE1aXVWYkQ3ajByRzE3MjNBb3gvZXJwZjE5ZEZi?=
 =?utf-8?B?YnQ5c2xXbVZLYnVicmVyTTd5L1l2SnV2ZG4vaUkzeGFrTEN6RmlvQ3lkTnJB?=
 =?utf-8?B?Tld6ZTBYVTlQK0lKQXVCMjZtS0pOK0xBQk42cnlDckNsSUxEUW9IWHlHazVi?=
 =?utf-8?B?WC9XMGlCaDBuNllDc3Z6d3FvbWp0N3pJa29rZ0dGVGRPOTkxV1IrTTB0L3FK?=
 =?utf-8?B?MU9HS1cvUE5XRUpxSE9RdnZTL1JncXc1dU5MUWlzUGE5emxXeC95RWNyeVdh?=
 =?utf-8?B?VjFqRkZWRGRMK3BrejBEMVVrdDNsckVFaEdFZU9RdzI0K0M4cFpRa3pBQXpJ?=
 =?utf-8?B?ZlYrM3dPUEJtei9JblBQWktwT2Zud0ZYTWlNSENXczZ6dThoc2tXYXFCR1Y3?=
 =?utf-8?B?ajVkOEtwM09QVFZvc1RBaEhTb3pIMDNFWlJCbmVYWDFJM2ZzWFJzREVVR2J0?=
 =?utf-8?B?L016WmpabS90VVl0bjFKRUlOdHdkNWM5RU1BSzJDQ2p3dzJoR2Vqck0xeWVT?=
 =?utf-8?B?SWc3bU9uTFBwWGJLTkVVZFVYNFFQRDlsLyt5ZXZKYnpMa2xDc0VJWnpOTWk2?=
 =?utf-8?B?TVlod2lLbDRJaFgyRDIwa1NtNHQ4TWJ3Z3JsbjJ1ZlJrVnV1NE9NdFkwYmtk?=
 =?utf-8?B?TEV2TlBrQXg2cXRiekcrVERaditHaWZjN0JYNU01WEl5M3lKaFB0KzBXZXpH?=
 =?utf-8?Q?sEo8Uxhv8ZYUX?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f367e137-825f-49c3-29d7-08d8e7b5d159
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 13:25:36.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoqlzVTRYcmfYAfz/LPG9SBGYPfrDubbxnjoRm7/jEc404Z5iweKTjYP2qAHtbsoIbB2IQ0J1Eo5bYrB7qK7ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5099
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIHwgNTAzICsrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFp
bi5oIHwgIDQzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA1NDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmgKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwMC4uMTZjNDgwNmZjOTMyCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKQEAgLTAsMCArMSw1MDMgQEAKKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBEZXZpY2UgcHJvYmUg
YW5kIHJlZ2lzdGVyLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExh
Ym9yYXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICog
Q29weXJpZ2h0IChjKSAyMDA4LCBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMu
bmV0PgorICogQ29weXJpZ2h0IChjKSAyMDA4IE5va2lhIENvcnBvcmF0aW9uIGFuZC9vciBpdHMg
c3Vic2lkaWFyeSgtaWVzKS4KKyAqIENvcHlyaWdodCAoYykgMjAwNy0yMDA5LCBDaHJpc3RpYW4g
TGFtcGFydGVyIDxjaHVua2VleUB3ZWIuZGU+CisgKiBDb3B5cmlnaHQgKGMpIDIwMDYsIE1pY2hh
ZWwgV3UgPGZsYW1pbmdpY2VAc291cm1pbGsubmV0PgorICogQ29weXJpZ2h0IChjKSAyMDA0LTIw
MDYgSmVhbi1CYXB0aXN0ZSBOb3RlIDxqYm5vdGVAZ21haWwuY29tPiwgZXQgYWwuCisgKi8KKyNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9vZi5oPgorI2luY2x1ZGUg
PGxpbnV4L29mX25ldC5oPgorI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4KKyNpbmNs
dWRlIDxsaW51eC9tbWMvc2Rpb19mdW5jLmg+CisjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPgor
I2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZmlybXdhcmUu
aD4KKworI2luY2x1ZGUgIm1haW4uaCIKKyNpbmNsdWRlICJ3ZnguaCIKKyNpbmNsdWRlICJmd2lv
LmgiCisjaW5jbHVkZSAiaHdpby5oIgorI2luY2x1ZGUgImJ1cy5oIgorI2luY2x1ZGUgImJoLmgi
CisjaW5jbHVkZSAic3RhLmgiCisjaW5jbHVkZSAia2V5LmgiCisjaW5jbHVkZSAic2Nhbi5oIgor
I2luY2x1ZGUgImRlYnVnLmgiCisjaW5jbHVkZSAiZGF0YV90eC5oIgorI2luY2x1ZGUgImhpZl90
eF9taWIuaCIKKyNpbmNsdWRlICJoaWZfYXBpX2NtZC5oIgorCisjZGVmaW5lIFdGWF9QRFNfTUFY
X1NJWkUgMTUwMAorCitNT0RVTEVfREVTQ1JJUFRJT04oIlNpbGljb24gTGFicyA4MDIuMTEgV2ly
ZWxlc3MgTEFOIGRyaXZlciBmb3IgV0Z4Iik7CitNT0RVTEVfQVVUSE9SKCJKw6lyw7RtZSBQb3Vp
bGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Iik7CitNT0RVTEVfTElDRU5TRSgiR1BM
Iik7CisKKyNkZWZpbmUgUkFURVRBQl9FTlQoX3JhdGUsIF9yYXRlaWQsIF9mbGFncykgeyBcCisJ
LmJpdHJhdGUgID0gKF9yYXRlKSwgICBcCisJLmh3X3ZhbHVlID0gKF9yYXRlaWQpLCBcCisJLmZs
YWdzICAgID0gKF9mbGFncyksICBcCit9CisKK3N0YXRpYyBzdHJ1Y3QgaWVlZTgwMjExX3JhdGUg
d2Z4X3JhdGVzW10gPSB7CisJUkFURVRBQl9FTlQoMTAsICAwLCAgMCksCisJUkFURVRBQl9FTlQo
MjAsICAxLCAgSUVFRTgwMjExX1JBVEVfU0hPUlRfUFJFQU1CTEUpLAorCVJBVEVUQUJfRU5UKDU1
LCAgMiwgIElFRUU4MDIxMV9SQVRFX1NIT1JUX1BSRUFNQkxFKSwKKwlSQVRFVEFCX0VOVCgxMTAs
IDMsICBJRUVFODAyMTFfUkFURV9TSE9SVF9QUkVBTUJMRSksCisJUkFURVRBQl9FTlQoNjAsICA2
LCAgMCksCisJUkFURVRBQl9FTlQoOTAsICA3LCAgMCksCisJUkFURVRBQl9FTlQoMTIwLCA4LCAg
MCksCisJUkFURVRBQl9FTlQoMTgwLCA5LCAgMCksCisJUkFURVRBQl9FTlQoMjQwLCAxMCwgMCks
CisJUkFURVRBQl9FTlQoMzYwLCAxMSwgMCksCisJUkFURVRBQl9FTlQoNDgwLCAxMiwgMCksCisJ
UkFURVRBQl9FTlQoNTQwLCAxMywgMCksCit9OworCisjZGVmaW5lIENIQU4yRyhfY2hhbm5lbCwg
X2ZyZXEsIF9mbGFncykgeyBcCisJLmJhbmQgPSBOTDgwMjExX0JBTkRfMkdIWiwgXAorCS5jZW50
ZXJfZnJlcSA9IChfZnJlcSksICAgIFwKKwkuaHdfdmFsdWUgPSAoX2NoYW5uZWwpLCAgICBcCisJ
LmZsYWdzID0gKF9mbGFncyksICAgICAgICAgXAorCS5tYXhfYW50ZW5uYV9nYWluID0gMCwgICAg
IFwKKwkubWF4X3Bvd2VyID0gMzAsICAgICAgICAgICBcCit9CisKK3N0YXRpYyBzdHJ1Y3QgaWVl
ZTgwMjExX2NoYW5uZWwgd2Z4XzJnaHpfY2hhbnRhYmxlW10gPSB7CisJQ0hBTjJHKDEsICAyNDEy
LCAwKSwKKwlDSEFOMkcoMiwgIDI0MTcsIDApLAorCUNIQU4yRygzLCAgMjQyMiwgMCksCisJQ0hB
TjJHKDQsICAyNDI3LCAwKSwKKwlDSEFOMkcoNSwgIDI0MzIsIDApLAorCUNIQU4yRyg2LCAgMjQz
NywgMCksCisJQ0hBTjJHKDcsICAyNDQyLCAwKSwKKwlDSEFOMkcoOCwgIDI0NDcsIDApLAorCUNI
QU4yRyg5LCAgMjQ1MiwgMCksCisJQ0hBTjJHKDEwLCAyNDU3LCAwKSwKKwlDSEFOMkcoMTEsIDI0
NjIsIDApLAorCUNIQU4yRygxMiwgMjQ2NywgMCksCisJQ0hBTjJHKDEzLCAyNDcyLCAwKSwKKwlD
SEFOMkcoMTQsIDI0ODQsIDApLAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
c3VwcG9ydGVkX2JhbmQgd2Z4X2JhbmRfMmdoeiA9IHsKKwkuY2hhbm5lbHMgPSB3ZnhfMmdoel9j
aGFudGFibGUsCisJLm5fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKHdmeF8yZ2h6X2NoYW50YWJsZSks
CisJLmJpdHJhdGVzID0gd2Z4X3JhdGVzLAorCS5uX2JpdHJhdGVzID0gQVJSQVlfU0laRSh3Znhf
cmF0ZXMpLAorCS5odF9jYXAgPSB7CisJCS8qIFJlY2VpdmUgY2FwcyAqLworCQkuY2FwID0gSUVF
RTgwMjExX0hUX0NBUF9HUk5fRkxEIHwgSUVFRTgwMjExX0hUX0NBUF9TR0lfMjAgfAorCQkgICAg
ICAgSUVFRTgwMjExX0hUX0NBUF9NQVhfQU1TRFUgfAorCQkgICAgICAgKDEgPDwgSUVFRTgwMjEx
X0hUX0NBUF9SWF9TVEJDX1NISUZUKSwKKwkJLmh0X3N1cHBvcnRlZCA9IDEsCisJCS5hbXBkdV9m
YWN0b3IgPSBJRUVFODAyMTFfSFRfTUFYX0FNUERVXzE2SywKKwkJLmFtcGR1X2RlbnNpdHkgPSBJ
RUVFODAyMTFfSFRfTVBEVV9ERU5TSVRZX05PTkUsCisJCS5tY3MgPSB7CisJCQkucnhfbWFzayA9
IHsgMHhGRiB9LCAvKiBNQ1MwIHRvIE1DUzcgKi8KKwkJCS5yeF9oaWdoZXN0ID0gY3B1X3RvX2xl
MTYoNzIpLAorCQkJLnR4X3BhcmFtcyA9IElFRUU4MDIxMV9IVF9NQ1NfVFhfREVGSU5FRCwKKwkJ
fSwKKwl9LAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfaWZhY2VfbGltaXQg
d2Rldl9pZmFjZV9saW1pdHNbXSA9IHsKKwl7IC5tYXggPSAxLCAudHlwZXMgPSBCSVQoTkw4MDIx
MV9JRlRZUEVfU1RBVElPTikgfSwKKwl7IC5tYXggPSAxLCAudHlwZXMgPSBCSVQoTkw4MDIxMV9J
RlRZUEVfQVApIH0sCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9pZmFjZV9j
b21iaW5hdGlvbiB3ZnhfaWZhY2VfY29tYmluYXRpb25zW10gPSB7CisJeworCQkubnVtX2RpZmZl
cmVudF9jaGFubmVscyA9IDIsCisJCS5tYXhfaW50ZXJmYWNlcyA9IDIsCisJCS5saW1pdHMgPSB3
ZGV2X2lmYWNlX2xpbWl0cywKKwkJLm5fbGltaXRzID0gQVJSQVlfU0laRSh3ZGV2X2lmYWNlX2xp
bWl0cyksCisJfQorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIHdmeF9v
cHMgPSB7CisJLnN0YXJ0CQkJPSB3Znhfc3RhcnQsCisJLnN0b3AJCQk9IHdmeF9zdG9wLAorCS5h
ZGRfaW50ZXJmYWNlCQk9IHdmeF9hZGRfaW50ZXJmYWNlLAorCS5yZW1vdmVfaW50ZXJmYWNlCT0g
d2Z4X3JlbW92ZV9pbnRlcmZhY2UsCisJLmNvbmZpZyAgICAgICAgICAgICAgICAgPSB3ZnhfY29u
ZmlnLAorCS50eAkJCT0gd2Z4X3R4LAorCS5qb2luX2lic3MJCT0gd2Z4X2pvaW5faWJzcywKKwku
bGVhdmVfaWJzcwkJPSB3ZnhfbGVhdmVfaWJzcywKKwkuY29uZl90eAkJPSB3ZnhfY29uZl90eCwK
KwkuaHdfc2NhbgkJPSB3ZnhfaHdfc2NhbiwKKwkuY2FuY2VsX2h3X3NjYW4JCT0gd2Z4X2NhbmNl
bF9od19zY2FuLAorCS5zdGFydF9hcAkJPSB3Znhfc3RhcnRfYXAsCisJLnN0b3BfYXAJCT0gd2Z4
X3N0b3BfYXAsCisJLnN0YV9hZGQJCT0gd2Z4X3N0YV9hZGQsCisJLnN0YV9yZW1vdmUJCT0gd2Z4
X3N0YV9yZW1vdmUsCisJLnNldF90aW0JCT0gd2Z4X3NldF90aW0sCisJLnNldF9rZXkJCT0gd2Z4
X3NldF9rZXksCisJLnNldF9ydHNfdGhyZXNob2xkCT0gd2Z4X3NldF9ydHNfdGhyZXNob2xkLAor
CS5zZXRfZGVmYXVsdF91bmljYXN0X2tleSA9IHdmeF9zZXRfZGVmYXVsdF91bmljYXN0X2tleSwK
KwkuYnNzX2luZm9fY2hhbmdlZAk9IHdmeF9ic3NfaW5mb19jaGFuZ2VkLAorCS5jb25maWd1cmVf
ZmlsdGVyCT0gd2Z4X2NvbmZpZ3VyZV9maWx0ZXIsCisJLmFtcGR1X2FjdGlvbgkJPSB3ZnhfYW1w
ZHVfYWN0aW9uLAorCS5mbHVzaAkJCT0gd2Z4X2ZsdXNoLAorCS5hZGRfY2hhbmN0eAkJPSB3Znhf
YWRkX2NoYW5jdHgsCisJLnJlbW92ZV9jaGFuY3R4CQk9IHdmeF9yZW1vdmVfY2hhbmN0eCwKKwku
Y2hhbmdlX2NoYW5jdHgJCT0gd2Z4X2NoYW5nZV9jaGFuY3R4LAorCS5hc3NpZ25fdmlmX2NoYW5j
dHgJPSB3ZnhfYXNzaWduX3ZpZl9jaGFuY3R4LAorCS51bmFzc2lnbl92aWZfY2hhbmN0eAk9IHdm
eF91bmFzc2lnbl92aWZfY2hhbmN0eCwKK307CisKK2Jvb2wgd2Z4X2FwaV9vbGRlcl90aGFuKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgbWFqb3IsIGludCBtaW5vcikKK3sKKwlpZiAod2Rldi0+
aHdfY2Fwcy5hcGlfdmVyc2lvbl9tYWpvciA8IG1ham9yKQorCQlyZXR1cm4gdHJ1ZTsKKwlpZiAo
d2Rldi0+aHdfY2Fwcy5hcGlfdmVyc2lvbl9tYWpvciA+IG1ham9yKQorCQlyZXR1cm4gZmFsc2U7
CisJaWYgKHdkZXYtPmh3X2NhcHMuYXBpX3ZlcnNpb25fbWlub3IgPCBtaW5vcikKKwkJcmV0dXJu
IHRydWU7CisJcmV0dXJuIGZhbHNlOworfQorCisvKiBUaGUgZGV2aWNlIG5lZWRzIGRhdGEgYWJv
dXQgdGhlIGFudGVubmEgY29uZmlndXJhdGlvbi4gVGhpcyBpbmZvcm1hdGlvbiBpbgorICogcHJv
dmlkZWQgYnkgUERTIChQbGF0Zm9ybSBEYXRhIFNldCwgdGhpcyBpcyB0aGUgd29yZGluZyB1c2Vk
IGluIFdGMjAwCisgKiBkb2N1bWVudGF0aW9uKSBmaWxlcy4gRm9yIGhhcmR3YXJlIGludGVncmF0
b3JzLCB0aGUgZnVsbCBwcm9jZXNzIHRvIGNyZWF0ZQorICogUERTIGZpbGVzIGlzIGRlc2NyaWJl
ZCBoZXJlOgorICogICBodHRwczpnaXRodWIuY29tL1NpbGljb25MYWJzL3dmeC1maXJtd2FyZS9i
bG9iL21hc3Rlci9QRFMvUkVBRE1FLm1kCisgKgorICogU28gdGhpcyBmdW5jdGlvbiBhaW1zIHRv
IHNlbmQgUERTIHRvIHRoZSBkZXZpY2UuIEhvd2V2ZXIsIHRoZSBQRFMgZmlsZSBpcworICogb2Z0
ZW4gYmlnZ2VyIHRoYW4gUnggYnVmZmVycyBvZiB0aGUgY2hpcCwgc28gaXQgaGFzIHRvIGJlIHNl
bnQgaW4gbXVsdGlwbGUKKyAqIHBhcnRzLgorICoKKyAqIEluIGFkZCwgdGhlIFBEUyBkYXRhIGNh
bm5vdCBiZSBzcGxpdCBhbnl3aGVyZS4gVGhlIFBEUyBmaWxlcyBjb250YWlucyB0cmVlCisgKiBz
dHJ1Y3R1cmVzLiBCcmFjZXMgYXJlIHVzZWQgdG8gZW50ZXIvbGVhdmUgYSBsZXZlbCBvZiB0aGUg
dHJlZSAoaW4gYSBKU09OCisgKiBmYXNoaW9uKS4gUERTIGZpbGVzIGNhbiBvbmx5IGJlZW4gc3Bs
aXQgYmV0d2VlbiByb290IG5vZGVzLgorICovCitpbnQgd2Z4X3NlbmRfcGRzKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2LCB1OCAqYnVmLCBzaXplX3QgbGVuKQoreworCWludCByZXQ7CisJaW50IHN0YXJ0
LCBicmFjZV9sZXZlbCwgaTsKKworCXN0YXJ0ID0gMDsKKwlicmFjZV9sZXZlbCA9IDA7CisJaWYg
KGJ1ZlswXSAhPSAneycpIHsKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJ2YWxpZCBQRFMgc3RhcnQg
d2l0aCAneycuIERpZCB5b3UgZm9yZ2V0IHRvIGNvbXByZXNzIGl0P1xuIik7CisJCXJldHVybiAt
RUlOVkFMOworCX0KKwlmb3IgKGkgPSAxOyBpIDwgbGVuIC0gMTsgaSsrKSB7CisJCWlmIChidWZb
aV0gPT0gJ3snKQorCQkJYnJhY2VfbGV2ZWwrKzsKKwkJaWYgKGJ1ZltpXSA9PSAnfScpCisJCQli
cmFjZV9sZXZlbC0tOworCQlpZiAoYnVmW2ldID09ICd9JyAmJiAhYnJhY2VfbGV2ZWwpIHsKKwkJ
CWkrKzsKKwkJCWlmIChpIC0gc3RhcnQgKyAxID4gV0ZYX1BEU19NQVhfU0laRSkKKwkJCQlyZXR1
cm4gLUVGQklHOworCQkJYnVmW3N0YXJ0XSA9ICd7JzsKKwkJCWJ1ZltpXSA9IDA7CisJCQlkZXZf
ZGJnKHdkZXYtPmRldiwgInNlbmQgUERTICclc30nXG4iLCBidWYgKyBzdGFydCk7CisJCQlidWZb
aV0gPSAnfSc7CisJCQlyZXQgPSBoaWZfY29uZmlndXJhdGlvbih3ZGV2LCBidWYgKyBzdGFydCwK
KwkJCQkJCWkgLSBzdGFydCArIDEpOworCQkJaWYgKHJldCA+IDApIHsKKwkJCQlkZXZfZXJyKHdk
ZXYtPmRldiwgIlBEUyBieXRlcyAlZCB0byAlZDogaW52YWxpZCBkYXRhICh1bnN1cHBvcnRlZCBv
cHRpb25zPylcbiIsCisJCQkJCXN0YXJ0LCBpKTsKKwkJCQlyZXR1cm4gLUVJTlZBTDsKKwkJCX0K
KwkJCWlmIChyZXQgPT0gLUVUSU1FRE9VVCkgeworCQkJCWRldl9lcnIod2Rldi0+ZGV2LCAiUERT
IGJ5dGVzICVkIHRvICVkOiBjaGlwIGRpZG4ndCByZXBseSAoY29ycnVwdGVkIGZpbGU/KVxuIiwK
KwkJCQkJc3RhcnQsIGkpOworCQkJCXJldHVybiByZXQ7CisJCQl9CisJCQlpZiAocmV0KSB7CisJ
CQkJZGV2X2Vycih3ZGV2LT5kZXYsICJQRFMgYnl0ZXMgJWQgdG8gJWQ6IGNoaXAgcmV0dXJuZWQg
YW4gdW5rbm93biBlcnJvclxuIiwKKwkJCQkJc3RhcnQsIGkpOworCQkJCXJldHVybiAtRUlPOwor
CQkJfQorCQkJYnVmW2ldID0gJywnOworCQkJc3RhcnQgPSBpOworCQl9CisJfQorCXJldHVybiAw
OworfQorCitzdGF0aWMgaW50IHdmeF9zZW5kX3BkYXRhX3BkcyhzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
dikKK3sKKwlpbnQgcmV0ID0gMDsKKwljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKnBkczsKKwl1OCAq
dG1wX2J1ZjsKKworCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJnBkcywgd2Rldi0+cGRhdGEuZmls
ZV9wZHMsIHdkZXYtPmRldik7CisJaWYgKHJldCkgeworCQlkZXZfZXJyKHdkZXYtPmRldiwgImNh
bid0IGxvYWQgUERTIGZpbGUgJXNcbiIsCisJCQl3ZGV2LT5wZGF0YS5maWxlX3Bkcyk7CisJCXJl
dHVybiByZXQ7CisJfQorCXRtcF9idWYgPSBrbWVtZHVwKHBkcy0+ZGF0YSwgcGRzLT5zaXplLCBH
RlBfS0VSTkVMKTsKKwlpZiAoIXRtcF9idWYpIHsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBy
ZWxlYXNlX2Z3OworCX0KKwlyZXQgPSB3Znhfc2VuZF9wZHMod2RldiwgdG1wX2J1ZiwgcGRzLT5z
aXplKTsKKwlrZnJlZSh0bXBfYnVmKTsKK3JlbGVhc2VfZnc6CisJcmVsZWFzZV9maXJtd2FyZShw
ZHMpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyB2b2lkIHdmeF9mcmVlX2NvbW1vbih2b2lk
ICpkYXRhKQoreworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gZGF0YTsKKworCW11dGV4X2Rlc3Ry
b3koJndkZXYtPnR4X3Bvd2VyX2xvb3BfaW5mb19sb2NrKTsKKwltdXRleF9kZXN0cm95KCZ3ZGV2
LT5yeF9zdGF0c19sb2NrKTsKKwltdXRleF9kZXN0cm95KCZ3ZGV2LT5jb25mX211dGV4KTsKKwlp
ZWVlODAyMTFfZnJlZV9odyh3ZGV2LT5odyk7Cit9CisKK3N0cnVjdCB3ZnhfZGV2ICp3ZnhfaW5p
dF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LAorCQkJCWNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZv
cm1fZGF0YSAqcGRhdGEsCisJCQkJY29uc3Qgc3RydWN0IGh3YnVzX29wcyAqaHdidXNfb3BzLAor
CQkJCXZvaWQgKmh3YnVzX3ByaXYpCit7CisJc3RydWN0IGllZWU4MDIxMV9odyAqaHc7CisJc3Ry
dWN0IHdmeF9kZXYgKndkZXY7CisKKwlodyA9IGllZWU4MDIxMV9hbGxvY19odyhzaXplb2Yoc3Ry
dWN0IHdmeF9kZXYpLCAmd2Z4X29wcyk7CisJaWYgKCFodykKKwkJcmV0dXJuIE5VTEw7CisKKwlT
RVRfSUVFRTgwMjExX0RFVihodywgZGV2KTsKKworCWllZWU4MDIxMV9od19zZXQoaHcsIFRYX0FN
UERVX1NFVFVQX0lOX0hXKTsKKwlpZWVlODAyMTFfaHdfc2V0KGh3LCBBTVBEVV9BR0dSRUdBVElP
Tik7CisJaWVlZTgwMjExX2h3X3NldChodywgQ09OTkVDVElPTl9NT05JVE9SKTsKKwlpZWVlODAy
MTFfaHdfc2V0KGh3LCBSRVBPUlRTX1RYX0FDS19TVEFUVVMpOworCWllZWU4MDIxMV9od19zZXQo
aHcsIFNVUFBPUlRTX0RZTkFNSUNfUFMpOworCWllZWU4MDIxMV9od19zZXQoaHcsIFNJR05BTF9E
Qk0pOworCWllZWU4MDIxMV9od19zZXQoaHcsIFNVUFBPUlRTX1BTKTsKKwlpZWVlODAyMTFfaHdf
c2V0KGh3LCBNRlBfQ0FQQUJMRSk7CisKKwlody0+dmlmX2RhdGFfc2l6ZSA9IHNpemVvZihzdHJ1
Y3Qgd2Z4X3ZpZik7CisJaHctPnN0YV9kYXRhX3NpemUgPSBzaXplb2Yoc3RydWN0IHdmeF9zdGFf
cHJpdik7CisJaHctPnF1ZXVlcyA9IDQ7CisJaHctPm1heF9yYXRlcyA9IDg7CisJaHctPm1heF9y
YXRlX3RyaWVzID0gODsKKwlody0+ZXh0cmFfdHhfaGVhZHJvb20gPSBzaXplb2Yoc3RydWN0IGhp
Zl9tc2cpCisJCQkJKyBzaXplb2Yoc3RydWN0IGhpZl9yZXFfdHgpCisJCQkJKyA0IC8qIGFsaWdu
bWVudCAqLyArIDggLyogVEtJUCBJViAqLzsKKwlody0+d2lwaHktPmludGVyZmFjZV9tb2RlcyA9
IEJJVChOTDgwMjExX0lGVFlQRV9TVEFUSU9OKSB8CisJCQkJICAgICBCSVQoTkw4MDIxMV9JRlRZ
UEVfQURIT0MpIHwKKwkJCQkgICAgIEJJVChOTDgwMjExX0lGVFlQRV9BUCk7CisJaHctPndpcGh5
LT5wcm9iZV9yZXNwX29mZmxvYWQgPSBOTDgwMjExX1BST0JFX1JFU1BfT0ZGTE9BRF9TVVBQT1JU
X1dQUyB8CisJCQkJCU5MODAyMTFfUFJPQkVfUkVTUF9PRkZMT0FEX1NVUFBPUlRfV1BTMiB8CisJ
CQkJCU5MODAyMTFfUFJPQkVfUkVTUF9PRkZMT0FEX1NVUFBPUlRfUDJQIHwKKwkJCQkJTkw4MDIx
MV9QUk9CRV9SRVNQX09GRkxPQURfU1VQUE9SVF84MDIxMVU7CisJaHctPndpcGh5LT5mZWF0dXJl
cyB8PSBOTDgwMjExX0ZFQVRVUkVfQVBfU0NBTjsKKwlody0+d2lwaHktPmZsYWdzIHw9IFdJUEhZ
X0ZMQUdfQVBfUFJPQkVfUkVTUF9PRkZMT0FEOworCWh3LT53aXBoeS0+ZmxhZ3MgfD0gV0lQSFlf
RkxBR19BUF9VQVBTRDsKKwlody0+d2lwaHktPm1heF9hcF9hc3NvY19zdGEgPSBISUZfTElOS19J
RF9NQVg7CisJaHctPndpcGh5LT5tYXhfc2Nhbl9zc2lkcyA9IDI7CisJaHctPndpcGh5LT5tYXhf
c2Nhbl9pZV9sZW4gPSBJRUVFODAyMTFfTUFYX0RBVEFfTEVOOworCWh3LT53aXBoeS0+bl9pZmFj
ZV9jb21iaW5hdGlvbnMgPSBBUlJBWV9TSVpFKHdmeF9pZmFjZV9jb21iaW5hdGlvbnMpOworCWh3
LT53aXBoeS0+aWZhY2VfY29tYmluYXRpb25zID0gd2Z4X2lmYWNlX2NvbWJpbmF0aW9uczsKKwlo
dy0+d2lwaHktPmJhbmRzW05MODAyMTFfQkFORF8yR0haXSA9IGRldm1fa21hbGxvYyhkZXYsIHNp
emVvZih3ZnhfYmFuZF8yZ2h6KSwgR0ZQX0tFUk5FTCk7CisJLyogRklYTUU6IGFsc28gY29weSB3
ZnhfcmF0ZXMgYW5kIHdmeF8yZ2h6X2NoYW50YWJsZSAqLworCW1lbWNweShody0+d2lwaHktPmJh
bmRzW05MODAyMTFfQkFORF8yR0haXSwgJndmeF9iYW5kXzJnaHosCisJICAgICAgIHNpemVvZih3
ZnhfYmFuZF8yZ2h6KSk7CisKKwl3ZGV2ID0gaHctPnByaXY7CisJd2Rldi0+aHcgPSBodzsKKwl3
ZGV2LT5kZXYgPSBkZXY7CisJd2Rldi0+aHdidXNfb3BzID0gaHdidXNfb3BzOworCXdkZXYtPmh3
YnVzX3ByaXYgPSBod2J1c19wcml2OworCW1lbWNweSgmd2Rldi0+cGRhdGEsIHBkYXRhLCBzaXpl
b2YoKnBkYXRhKSk7CisJb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LT5vZl9ub2RlLCAic2ls
YWJzLGFudGVubmEtY29uZmlnLWZpbGUiLAorCQkJCSZ3ZGV2LT5wZGF0YS5maWxlX3Bkcyk7CisJ
d2Rldi0+cGRhdGEuZ3Bpb193YWtldXAgPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJ3
YWtldXAiLAorCQkJCQkJCSAgR1BJT0RfT1VUX0xPVyk7CisJaWYgKElTX0VSUih3ZGV2LT5wZGF0
YS5ncGlvX3dha2V1cCkpCisJCXJldHVybiBOVUxMOworCWlmICh3ZGV2LT5wZGF0YS5ncGlvX3dh
a2V1cCkKKwkJZ3Bpb2Rfc2V0X2NvbnN1bWVyX25hbWUod2Rldi0+cGRhdGEuZ3Bpb193YWtldXAs
ICJ3Znggd2FrZXVwIik7CisKKwltdXRleF9pbml0KCZ3ZGV2LT5jb25mX211dGV4KTsKKwltdXRl
eF9pbml0KCZ3ZGV2LT5yeF9zdGF0c19sb2NrKTsKKwltdXRleF9pbml0KCZ3ZGV2LT50eF9wb3dl
cl9sb29wX2luZm9fbG9jayk7CisJaW5pdF9jb21wbGV0aW9uKCZ3ZGV2LT5maXJtd2FyZV9yZWFk
eSk7CisJSU5JVF9ERUxBWUVEX1dPUksoJndkZXYtPmNvb2xpbmdfdGltZW91dF93b3JrLAorCQkJ
ICB3ZnhfY29vbGluZ190aW1lb3V0X3dvcmspOworCXNrYl9xdWV1ZV9oZWFkX2luaXQoJndkZXYt
PnR4X3BlbmRpbmcpOworCWluaXRfd2FpdHF1ZXVlX2hlYWQoJndkZXYtPnR4X2RlcXVldWUpOwor
CXdmeF9pbml0X2hpZl9jbWQoJndkZXYtPmhpZl9jbWQpOworCXdkZXYtPmZvcmNlX3BzX3RpbWVv
dXQgPSAtMTsKKworCWlmIChkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCB3ZnhfZnJlZV9j
b21tb24sIHdkZXYpKQorCQlyZXR1cm4gTlVMTDsKKworCXJldHVybiB3ZGV2OworfQorCitpbnQg
d2Z4X3Byb2JlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCWludCBpOworCWludCBlcnI7CisJ
Y29uc3Qgdm9pZCAqbWFjYWRkcjsKKwlzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvX3NhdmVkOworCisJ
LyogRHVyaW5nIGZpcnN0IHBhcnQgb2YgYm9vdCwgZ3Bpb193YWtldXAgY2Fubm90IHlldCBiZWVu
IHVzZWQuIFNvCisJICogcHJldmVudCBiaCgpIHRvIHRvdWNoIGl0LgorCSAqLworCWdwaW9fc2F2
ZWQgPSB3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cDsKKwl3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCA9
IE5VTEw7CisJd2Rldi0+cG9sbF9pcnEgPSB0cnVlOworCisJd2Z4X2JoX3JlZ2lzdGVyKHdkZXYp
OworCisJZXJyID0gd2Z4X2luaXRfZGV2aWNlKHdkZXYpOworCWlmIChlcnIpCisJCWdvdG8gZXJy
MDsKKworCXdmeF9iaF9wb2xsX2lycSh3ZGV2KTsKKwllcnIgPSB3YWl0X2Zvcl9jb21wbGV0aW9u
X3RpbWVvdXQoJndkZXYtPmZpcm13YXJlX3JlYWR5LCAxICogSFopOworCWlmIChlcnIgPD0gMCkg
eworCQlpZiAoZXJyID09IDApIHsKKwkJCWRldl9lcnIod2Rldi0+ZGV2LCAidGltZW91dCB3aGls
ZSB3YWl0aW5nIGZvciBzdGFydHVwIGluZGljYXRpb25cbiIpOworCQkJZXJyID0gLUVUSU1FRE9V
VDsKKwkJfSBlbHNlIGlmIChlcnIgPT0gLUVSRVNUQVJUU1lTKSB7CisJCQlkZXZfaW5mbyh3ZGV2
LT5kZXYsICJwcm9iZSBpbnRlcnJ1cHRlZCBieSB1c2VyXG4iKTsKKwkJfQorCQlnb3RvIGVycjA7
CisJfQorCisJLyogRklYTUU6IGZpbGwgd2lwaHk6Omh3X3ZlcnNpb24gKi8KKwlkZXZfaW5mbyh3
ZGV2LT5kZXYsICJzdGFydGVkIGZpcm13YXJlICVkLiVkLiVkIFwiJXNcIiAoQVBJOiAlZC4lZCwg
a2V5c2V0OiAlMDJYLCBjYXBzOiAweCUuOFgpXG4iLAorCQkgd2Rldi0+aHdfY2Fwcy5maXJtd2Fy
ZV9tYWpvciwgd2Rldi0+aHdfY2Fwcy5maXJtd2FyZV9taW5vciwKKwkJIHdkZXYtPmh3X2NhcHMu
ZmlybXdhcmVfYnVpbGQsIHdkZXYtPmh3X2NhcHMuZmlybXdhcmVfbGFiZWwsCisJCSB3ZGV2LT5o
d19jYXBzLmFwaV92ZXJzaW9uX21ham9yLCB3ZGV2LT5od19jYXBzLmFwaV92ZXJzaW9uX21pbm9y
LAorCQkgd2Rldi0+a2V5c2V0LCB3ZGV2LT5od19jYXBzLmxpbmtfbW9kZSk7CisJc25wcmludGYo
d2Rldi0+aHctPndpcGh5LT5md192ZXJzaW9uLAorCQkgc2l6ZW9mKHdkZXYtPmh3LT53aXBoeS0+
ZndfdmVyc2lvbiksCisJCSAiJWQuJWQuJWQiLAorCQkgd2Rldi0+aHdfY2Fwcy5maXJtd2FyZV9t
YWpvciwKKwkJIHdkZXYtPmh3X2NhcHMuZmlybXdhcmVfbWlub3IsCisJCSB3ZGV2LT5od19jYXBz
LmZpcm13YXJlX2J1aWxkKTsKKworCWlmICh3ZnhfYXBpX29sZGVyX3RoYW4od2RldiwgMSwgMCkp
IHsKKwkJZGV2X2Vycih3ZGV2LT5kZXYsCisJCQkidW5zdXBwb3J0ZWQgZmlybXdhcmUgQVBJIHZl
cnNpb24gKGV4cGVjdCAxIHdoaWxlIGZpcm13YXJlIHJldHVybnMgJWQpXG4iLAorCQkJd2Rldi0+
aHdfY2Fwcy5hcGlfdmVyc2lvbl9tYWpvcik7CisJCWVyciA9IC1FTk9UU1VQUDsKKwkJZ290byBl
cnIwOworCX0KKworCWlmICh3ZGV2LT5od19jYXBzLmxpbmtfbW9kZSA9PSBTRUNfTElOS19FTkZP
UkNFRCkgeworCQlkZXZfZXJyKHdkZXYtPmRldiwKKwkJCSJjaGlwIHJlcXVpcmUgc2VjdXJlX2xp
bmssIGJ1dCBjYW4ndCBuZWdvdGlhdGUgaXRcbiIpOworCQlnb3RvIGVycjA7CisJfQorCisJaWYg
KHdkZXYtPmh3X2NhcHMucmVnaW9uX3NlbF9tb2RlKSB7CisJCXdkZXYtPmh3LT53aXBoeS0+YmFu
ZHNbTkw4MDIxMV9CQU5EXzJHSFpdLT5jaGFubmVsc1sxMV0uZmxhZ3MgfD0gSUVFRTgwMjExX0NI
QU5fTk9fSVI7CisJCXdkZXYtPmh3LT53aXBoeS0+YmFuZHNbTkw4MDIxMV9CQU5EXzJHSFpdLT5j
aGFubmVsc1sxMl0uZmxhZ3MgfD0gSUVFRTgwMjExX0NIQU5fTk9fSVI7CisJCXdkZXYtPmh3LT53
aXBoeS0+YmFuZHNbTkw4MDIxMV9CQU5EXzJHSFpdLT5jaGFubmVsc1sxM10uZmxhZ3MgfD0gSUVF
RTgwMjExX0NIQU5fRElTQUJMRUQ7CisJfQorCisJZGV2X2RiZyh3ZGV2LT5kZXYsICJzZW5kaW5n
IGNvbmZpZ3VyYXRpb24gZmlsZSAlc1xuIiwKKwkJd2Rldi0+cGRhdGEuZmlsZV9wZHMpOworCWVy
ciA9IHdmeF9zZW5kX3BkYXRhX3Bkcyh3ZGV2KTsKKwlpZiAoZXJyIDwgMCkKKwkJZ290byBlcnIw
OworCisJd2Rldi0+cG9sbF9pcnEgPSBmYWxzZTsKKwllcnIgPSB3ZGV2LT5od2J1c19vcHMtPmly
cV9zdWJzY3JpYmUod2Rldi0+aHdidXNfcHJpdik7CisJaWYgKGVycikKKwkJZ290byBlcnIwOwor
CisJZXJyID0gaGlmX3VzZV9tdWx0aV90eF9jb25mKHdkZXYsIHRydWUpOworCWlmIChlcnIpCisJ
CWRldl9lcnIod2Rldi0+ZGV2LCAibWlzY29uZmlndXJlZCBJUlE/XG4iKTsKKworCXdkZXYtPnBk
YXRhLmdwaW9fd2FrZXVwID0gZ3Bpb19zYXZlZDsKKwlpZiAod2Rldi0+cGRhdGEuZ3Bpb193YWtl
dXApIHsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsCisJCQkiZW5hYmxlICdxdWllc2NlbnQnIHBvd2Vy
IG1vZGUgd2l0aCB3YWtldXAgR1BJTyBhbmQgUERTIGZpbGUgJXNcbiIsCisJCQl3ZGV2LT5wZGF0
YS5maWxlX3Bkcyk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCh3ZGV2LT5wZGF0YS5ncGlv
X3dha2V1cCwgMSk7CisJCWNvbnRyb2xfcmVnX3dyaXRlKHdkZXYsIDApOworCQloaWZfc2V0X29w
ZXJhdGlvbmFsX21vZGUod2RldiwgSElGX09QX1BPV0VSX01PREVfUVVJRVNDRU5UKTsKKwl9IGVs
c2UgeworCQloaWZfc2V0X29wZXJhdGlvbmFsX21vZGUod2RldiwgSElGX09QX1BPV0VSX01PREVf
RE9aRSk7CisJfQorCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUod2Rldi0+YWRkcmVzc2Vz
KTsgaSsrKSB7CisJCWV0aF96ZXJvX2FkZHIod2Rldi0+YWRkcmVzc2VzW2ldLmFkZHIpOworCQlt
YWNhZGRyID0gb2ZfZ2V0X21hY19hZGRyZXNzKHdkZXYtPmRldi0+b2Zfbm9kZSk7CisJCWlmICgh
SVNfRVJSX09SX05VTEwobWFjYWRkcikpIHsKKwkJCWV0aGVyX2FkZHJfY29weSh3ZGV2LT5hZGRy
ZXNzZXNbaV0uYWRkciwgbWFjYWRkcik7CisJCQl3ZGV2LT5hZGRyZXNzZXNbaV0uYWRkcltFVEhf
QUxFTiAtIDFdICs9IGk7CisJCX0gZWxzZSB7CisJCQlldGhlcl9hZGRyX2NvcHkod2Rldi0+YWRk
cmVzc2VzW2ldLmFkZHIsCisJCQkJCXdkZXYtPmh3X2NhcHMubWFjX2FkZHJbaV0pOworCQl9CisJ
CWlmICghaXNfdmFsaWRfZXRoZXJfYWRkcih3ZGV2LT5hZGRyZXNzZXNbaV0uYWRkcikpIHsKKwkJ
CWRldl93YXJuKHdkZXYtPmRldiwgInVzaW5nIHJhbmRvbSBNQUMgYWRkcmVzc1xuIik7CisJCQll
dGhfcmFuZG9tX2FkZHIod2Rldi0+YWRkcmVzc2VzW2ldLmFkZHIpOworCQl9CisJCWRldl9pbmZv
KHdkZXYtPmRldiwgIk1BQyBhZGRyZXNzICVkOiAlcE1cbiIsIGksCisJCQkgd2Rldi0+YWRkcmVz
c2VzW2ldLmFkZHIpOworCX0KKwl3ZGV2LT5ody0+d2lwaHktPm5fYWRkcmVzc2VzID0gQVJSQVlf
U0laRSh3ZGV2LT5hZGRyZXNzZXMpOworCXdkZXYtPmh3LT53aXBoeS0+YWRkcmVzc2VzID0gd2Rl
di0+YWRkcmVzc2VzOworCisJZXJyID0gaWVlZTgwMjExX3JlZ2lzdGVyX2h3KHdkZXYtPmh3KTsK
KwlpZiAoZXJyKQorCQlnb3RvIGVycjE7CisKKwllcnIgPSB3ZnhfZGVidWdfaW5pdCh3ZGV2KTsK
KwlpZiAoZXJyKQorCQlnb3RvIGVycjI7CisKKwlyZXR1cm4gMDsKKworZXJyMjoKKwlpZWVlODAy
MTFfdW5yZWdpc3Rlcl9odyh3ZGV2LT5odyk7CitlcnIxOgorCXdkZXYtPmh3YnVzX29wcy0+aXJx
X3Vuc3Vic2NyaWJlKHdkZXYtPmh3YnVzX3ByaXYpOworZXJyMDoKKwl3ZnhfYmhfdW5yZWdpc3Rl
cih3ZGV2KTsKKwlyZXR1cm4gZXJyOworfQorCit2b2lkIHdmeF9yZWxlYXNlKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2KQoreworCWllZWU4MDIxMV91bnJlZ2lzdGVyX2h3KHdkZXYtPmh3KTsKKwloaWZf
c2h1dGRvd24od2Rldik7CisJd2Rldi0+aHdidXNfb3BzLT5pcnFfdW5zdWJzY3JpYmUod2Rldi0+
aHdidXNfcHJpdik7CisJd2Z4X2JoX3VucmVnaXN0ZXIod2Rldik7Cit9CisKK3N0YXRpYyBpbnQg
X19pbml0IHdmeF9jb3JlX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0ID0gMDsKKworCWlmIChJU19F
TkFCTEVEKENPTkZJR19TUEkpKQorCQlyZXQgPSBzcGlfcmVnaXN0ZXJfZHJpdmVyKCZ3Znhfc3Bp
X2RyaXZlcik7CisJaWYgKElTX0VOQUJMRUQoQ09ORklHX01NQykgJiYgIXJldCkKKwkJcmV0ID0g
c2Rpb19yZWdpc3Rlcl9kcml2ZXIoJndmeF9zZGlvX2RyaXZlcik7CisJcmV0dXJuIHJldDsKK30K
K21vZHVsZV9pbml0KHdmeF9jb3JlX2luaXQpOworCitzdGF0aWMgdm9pZCBfX2V4aXQgd2Z4X2Nv
cmVfZXhpdCh2b2lkKQoreworCWlmIChJU19FTkFCTEVEKENPTkZJR19NTUMpKQorCQlzZGlvX3Vu
cmVnaXN0ZXJfZHJpdmVyKCZ3Znhfc2Rpb19kcml2ZXIpOworCWlmIChJU19FTkFCTEVEKENPTkZJ
R19TUEkpKQorCQlzcGlfdW5yZWdpc3Rlcl9kcml2ZXIoJndmeF9zcGlfZHJpdmVyKTsKK30KK21v
ZHVsZV9leGl0KHdmeF9jb3JlX2V4aXQpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3Mvc2lsYWJzL3dmeC9tYWluLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21h
aW4uaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjExNWFiZDJkNDM3
OAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFp
bi5oCkBAIC0wLDAgKzEsNDMgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9ubHkgKi8KKy8qCisgKiBEZXZpY2UgcHJvYmUgYW5kIHJlZ2lzdGVyLgorICoKKyAqIENvcHly
aWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29weXJp
Z2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICogQ29weXJpZ2h0IChjKSAyMDA2LCBNaWNoYWVs
IFd1IDxmbGFtaW5naWNlQHNvdXJtaWxrLm5ldD4KKyAqIENvcHlyaWdodCAyMDA0LTIwMDYgSmVh
bi1CYXB0aXN0ZSBOb3RlIDxqYm5vdGVAZ21haWwuY29tPiwgZXQgYWwuCisgKi8KKyNpZm5kZWYg
V0ZYX01BSU5fSAorI2RlZmluZSBXRlhfTUFJTl9ICisKKyNpbmNsdWRlIDxsaW51eC9kZXZpY2Uu
aD4KKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+CisKKyNpbmNsdWRlICJoaWZfYXBp
X2dlbmVyYWwuaCIKKworc3RydWN0IHdmeF9kZXY7CitzdHJ1Y3QgaHdidXNfb3BzOworCitzdHJ1
Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgeworCS8qIEtleXNldCBhbmQgIi5zZWMiIGV4dGVuc2lvbiB3
aWxsIGJlIGFwcGVuZGVkIHRvIHRoaXMgc3RyaW5nICovCisJY29uc3QgY2hhciAqZmlsZV9mdzsK
Kwljb25zdCBjaGFyICpmaWxlX3BkczsKKwlzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvX3dha2V1cDsK
KwkvKiBpZiB0cnVlIEhJRiBEX291dCBpcyBzYW1wbGVkIG9uIHRoZSByaXNpbmcgZWRnZSBvZiB0
aGUgY2xvY2sKKwkgKiAoaW50ZW5kZWQgdG8gYmUgdXNlZCBpbiA1ME1oeiBTRElPKQorCSAqLwor
CWJvb2wgdXNlX3Jpc2luZ19jbGs7Cit9OworCitzdHJ1Y3Qgd2Z4X2RldiAqd2Z4X2luaXRfY29t
bW9uKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQljb25zdCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2Rh
dGEgKnBkYXRhLAorCQkJCWNvbnN0IHN0cnVjdCBod2J1c19vcHMgKmh3YnVzX29wcywKKwkJCQl2
b2lkICpod2J1c19wcml2KTsKKworaW50IHdmeF9wcm9iZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7
Cit2b2lkIHdmeF9yZWxlYXNlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKKworYm9vbCB3ZnhfYXBp
X29sZGVyX3RoYW4oc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCBtYWpvciwgaW50IG1pbm9yKTsK
K2ludCB3Znhfc2VuZF9wZHMoc3RydWN0IHdmeF9kZXYgKndkZXYsIHU4ICpidWYsIHNpemVfdCBs
ZW4pOworCisjZW5kaWYKLS0gCjIuMzAuMgoK

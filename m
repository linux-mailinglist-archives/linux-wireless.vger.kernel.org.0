Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF91D42DB96
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhJNOdE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 10:33:04 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:13281
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231640AbhJNOc7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 10:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwKT86D8XR35aBG5P1mWUOnb8ssJocjYlbmQ2vXs07CRg9JPZXRwu9kFpR96LV+AxHCnDPI9JnFIPpAk2D48eF2IcBegpr8sb0pKnpu+YPs8VB3EQ6fjDFs1CE4dw91hJbhhFj4yDoWv3cRQTTRczBLaT1bL0ZOfi2stKqVUy8pTFLJH2rIBe3zPyDEMKFLoqui61D/Z0IJ14AXr3FBYnHSQ60whPPio6vltZJ/puC31CNGaFT1VrvrZ1B32tJV6VGVnZWobwtyLYHZpN55TjY5BoWSdDR0s5w4D3GORPeEUtnJH/QWiHhic5YbTMeCZCdFRm0bNPJbbUuPO/FFuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fUKTfTAfwy+7eaWpDgFDrxaFUgPQXq/FXSbMTtXJ5g=;
 b=CZR26VYut8Ywc6vh9ipmf0nLfucF983CwKOq2E/gtAIal944ayB7qhbNbyKCwEg5msZK/ZFQ/OQ//fuc/BEl62chYtwEeTeIhwtq7U7yZCA4TX2HhfJzWIrvAZiz94K8hTEfKy5YEEJVhPxRMLZ0lhXOU8qF8RZUqqFPmfR4ouk92ZIEnomBDz10fyyI4J101zJxMsr7h9iklVFAdJivBtV8bT+to80joLh/nFoz2xh8x3fne0AToMt7Hj5ABGRzBwP27VrgL/ycERKZhklXm0pMdy/GzRM89ToANDpdSu7EUjgsCctyD59kUeATZAUZVrX3BvQBd46RCldT4jtyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fUKTfTAfwy+7eaWpDgFDrxaFUgPQXq/FXSbMTtXJ5g=;
 b=mjl/n8lFeeXR5yJuoBSczwD2IZnYmfXV3xyoTftKbQ7EHiZntVOuw1Vytf/P2syb7/rZQvKikAAeVuWils5k7n8StDkjYP9nH6RSIqL0qVfCbEpJ5KLCpkMT3DerurjJGETGni8vFEeQ7Y9wdUbaju65K+Aw26HsC81edby66U0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 14:30:52 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 14:30:52 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [RFC PATCH 0/2] mmc: allow to rely on the DT to apply quirks
Date:   Thu, 14 Oct 2021 16:30:29 +0200
Message-Id: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::20) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 14:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f455f4b6-d4ce-48c8-f763-08d98f1f3985
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB564300879A3FFEE8517F953F93B89@PH0PR11MB5643.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muD8dzqGSMcaoAvGTjvBrVWiCyScCaqzefRNo0OhCICPWGicDuwv3JDqIHNSfQl2mP3u43ToSa1YW7wlMLaxmhwS9FswcDIi8Mgnimvo6noqK8z3I0WpKpD1EULOBE8LvWNpeYdV14yGHN+QAakIZu5UUC7/ENvp2iATlhozrdKnU3wMYGgCk8uuUeWCmNdcx26dDGpUOwup+MqZp8+vcBXMg8XUTB6hg2Is2G4nmliwHASwDzTKd0Z7u6+q5HlbQua+7gnVuOapximqf3TARwEFd3qlcU/E80zDGo9cyVj4mUnPeNu2sAohkEuC6s+YyG10zKWIxMVL+GTnM2/HrIREAyVn4JhD+mELENjR2gSc6OTSmm91klbeTLC8t3FgryC6C6TE+uUd+lUlX6Y3cYjrBn7b4pODz+ZvKe6eGgm+MCJLxtEuBlwdf2lko8RKceO5a8rBSKwU/+qCwzE6EqHhAnoq/Jlx9W6PxxJk8Vi2rpyDarR8A/8invkDKpj22dTND8L65lOU7EzCMDg+YEARq+Bp6ovtTNOJbNovSya/OwTGBe0BFVtJcmyYAxOKC9Q2lv1m9oG7vVyXycagVSpuJnbwVAhHXAuuG1zUwvjsNAj9FDMdt+1gfWI1PCJh+1L7TFPcxq1FOKXjtFjfcjds1z+gJYL+QtX6HAVBLFkIFAmH+84fZl7eQm08q+xDa0uH1LuN3QlEoUerxJ0H113AaHbi6qV+wmRqCpkmIJk/LzpNOYjVi4bJScfY5xl7GdOAzZ4N/j/LxwcIGVbc/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(38350700002)(7696005)(508600001)(186003)(8676002)(316002)(966005)(956004)(38100700002)(6916009)(54906003)(66476007)(2906002)(6666004)(86362001)(36756003)(107886003)(8936002)(4326008)(26005)(66946007)(83380400001)(1076003)(2616005)(4744005)(66556008)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxQM0tuS3l0M3RkZ3I1bzY1cDlYem1LeElacnNsMzc0eWt0aXZoQWRFZ0hF?=
 =?utf-8?B?ei93enFQM2lSaW04NGlrdmRPb2MwcHV4VGJwTVlNTkN0YzFIb0hkeVkrZnhv?=
 =?utf-8?B?MnRaYk1JMzR1S0ZVbGVGUEJHY09WelU5SmxTT25Wb1ltZUxjbU45RVpybzNj?=
 =?utf-8?B?Mi9XQ2p4WlRQaTZBK3BYYjBRc1ZQRGZ0SXhPMTVGZk5kSzcwSzlEcUhtWGdG?=
 =?utf-8?B?Vzk5cEVjd01yZjE4bXVBc2VKeGtLSlhyODJFaHVidmlUT2s0bUpleGlxcnor?=
 =?utf-8?B?bjFMb09hS21Yc2JmWkdlUVlDWjI1bVFSdTMwQTdoOWpHRnllS1A1VC9XM1FQ?=
 =?utf-8?B?MFBKbzNrM21lbXBqZC91Y1p1dmdPUVFJR3VhbDF1Z1VwdEt2SnYwdkZ3U3Va?=
 =?utf-8?B?Zm93bDJ1VmpyUHB0YTdkZFhlcnhLVk1WcnRNKzBobmpPbmRCTDNFbmlvd3JT?=
 =?utf-8?B?TGdhUzkydGIyYWZiU1hEbnBjWGh5MDNLcVgvSi9qdGJmNGE4eTgxaFZ0T05S?=
 =?utf-8?B?QnhpVm9GMG94ZnRXaXkrV0I5eEJlb083TzQ3U1VsaHhCVy83eU1yazA3Rmdr?=
 =?utf-8?B?NUdIMGx0czg3VTdTa1NlMS84Y0dWNGhyQ3plaDR6ZFpXeE1tY042ZUdlZGxv?=
 =?utf-8?B?S2dHOTJPWmtZZllWV1BiTnI2S2VlbXNMZEJSQ0hTblFLS1ZYR1ZqT1ZuVW1u?=
 =?utf-8?B?Q1hCUmJoTGszOFNjOFdnY2d2djBKbW85SnV3QWkwdE5PRndnWjJCQ2RiRkZ0?=
 =?utf-8?B?ekRKWmlDSDFYOElDZUJmY0p3VTRaTUNOYUFnODRhVHM5emYzR0R3NWJlWFlF?=
 =?utf-8?B?U2FpamR6WnZFTDZHRVM4TGE1VW52OVVkS2xHczJkYm9Cc3NTMzZuUkpPa0Rr?=
 =?utf-8?B?TG1sTWxXbGswU1pGSnY0TElHLzVGYTlvbzE4RmpsOEJBSElTRE1xbDM3QTJw?=
 =?utf-8?B?M2d0NkNqM09hbVZBY2VMRXRBZjgzMFNsL2FSNWxzYVhuVlVBRnltbExiQ3Rk?=
 =?utf-8?B?QVNZMy9KQkx3bS9tdDVHeUEzaU1ESFBVZFdvTlg2cW9LeENlbHVYWlNJZC9o?=
 =?utf-8?B?ZU9nN05KYTJpLzlqRExDUVdWcnpVc2JwVjdncVBab0tIMFZXL3BsbFVvRHBv?=
 =?utf-8?B?N1A3eFB3dXZUM2xWN0J6Tk9xY1d5N05aVW9nK2F2QmR0dm0wdjBVaW5OZ2xN?=
 =?utf-8?B?RnB5Tmx6VE05aG83MWNiSGNHUTJMbnZxZHZtSFI1cGdxVGhQbVc3cStYc3I3?=
 =?utf-8?B?RGw1eEdiKytUYW51RDV0Y2xhMytZYkNpODNFaHlxR3pVODFZbjFaRkowM1U2?=
 =?utf-8?B?MlBsaUgyUWlTeHVsY2xueGNGSVY5dlk2eXM0L1BKbVUwTW50L1JhWGI2MzBG?=
 =?utf-8?B?WE9hb25adEc2TktHS3BuRlVJSFZPSnJmVjV4Rk9Xa1lMaUFoVkE1cUw1V0c0?=
 =?utf-8?B?Qkk2RFFQVkN3QUNqMkhvdmduU3I5SFVyYmREQVh3NXk4Zzk3L01EK2Y3SFMr?=
 =?utf-8?B?MUVFSjMzemc5SEZOK2hDenFSU3l6cWM3eEJLWVBZZGptenF0d1VxZVJFcHBR?=
 =?utf-8?B?VVRpL3NDK2N2RldQM1pBS3VEU0JpaUxVUmVuay8wSjhQV1RFcTlkZDRPSHhU?=
 =?utf-8?B?Wk9Razl0Nmp6VkZSM0hQVExVOGdueXAzS0tjQytFQnIrdHM2bDdaNmkxK01H?=
 =?utf-8?B?MlVBWS9ERDhGTnpqanRwTEh6ektjMGRqZUp5a2xCVG5wZ21UV2ZwUTZqMFBC?=
 =?utf-8?Q?JKIjyPiSc+hw/O5oobLxf1i7DlQHp7LjZ/CvDSp?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f455f4b6-d4ce-48c8-f763-08d98f1f3985
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 14:30:52.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUVLcw8rTy8iFdu7zhAzLYu8RJg2w3il0wTWFEqnjktz7uWzoZH5Hnaey64aWhborRfe1EL2Sfs9GmFrbjEHGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKSGkg
VWxmLAoKSSB0cnkgdG8gd3JpdGUgYSBwYXRjaCB0byBwcm9ibGVtIGRpc2N1c3NlZCBoZXJlWzFd
LgoKVGhpcyBwYXRjaCBpcyBub3QgY29tcGxldGUuIEVzcGVjaWFsbHksIGl0IGRvZXMgbm90IGNv
bnRhaW5zIHRoZSBuZWNlc3NhcnkKRklYVVAgbWFjcm8gaW4gY2FyZC5oLiBJIHdvdWxkIGxpa2Ug
dG8gaGF2ZSB5b3VyIGNvbW1lbnQgb24gdGhlIGNvbmNlcHQuCgpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbmV0ZGV2L0NBUER5S0ZyNjJLeWtnMz05V2lYQVY4VVRvcWp3OGdqNHQ2YmJNN3BH
UStpR0dRUkxtZ0BtYWlsLmdtYWlsLmNvbS8KCkrDqXLDtG1lIFBvdWlsbGVyICgyKToKICBtbWM6
IHJld3JpdGUgbW1jX2ZpeHVwX2RldmljZSgpCiAgbW1jOiBhbGxvdyB0byBtYXRjaCB0aGUgZGV2
aWNlIHRyZWUgdG8gYXBwbHkgcXVpcmtzCgogZHJpdmVycy9tbWMvY29yZS9jYXJkLmggICB8ICAz
ICsrCiBkcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIHwgNTkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDE3
IGRlbGV0aW9ucygtKQoKLS0gCjIuMzMuMAoK

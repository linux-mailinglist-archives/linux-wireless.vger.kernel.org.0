Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF81742D0A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjF2TR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 15:17:29 -0400
Received: from mail-dm6nam12on2090.outbound.protection.outlook.com ([40.107.243.90]:37504
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231466AbjF2TRI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 15:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UszXtx7c16Zc7zLmSlkRT2j0tt2ah94rnMp6Ej6bNoaAcVPFt3qbvg0zh5QiGrbjxfl+j7SnGF4stvAEUjThcvTMIxFclHHeEB4fijZFNJqQVROrIvh6DdNUE2jPd3iVD82752EeoXkc5ON8BfULFUxAS+d4OeSFK56TEfPfEHY/dBb7/QwGVHKg8NiGI6cIrEspInUQeTERwT2PgF3ZbEBEx3S9w6bYVbByOmvsgfwtBbqdTOf8v2gXI7lORqeFZLVPywRz/bakljREBjkUxQaqxRE90mlF4ys2wUpkTyOtrPpYoo4QmvHwu9erPg/X5Tyg4alf6a5mt38+5qRXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hWmxerz9GlRMWTTUxBhBsyg2E7A5CqwIPGeu12c3t8=;
 b=Mvgr3oSLvpdm0wxICnamxNusJHAK+xbGFDsXK99LczJgzclRm19bp1vH8Ja9QQuCGjticipHSCNaqXmurFJzD2OrI4uyMD8RcUBU66AtNgjmoNQA4V1lozzPs1Gg1v3fH6UN+vjXdIO6T0m/xkssyvXtakTjabFesI33+Hyt0cnimV8ci/8vsPK3kQxOTKbhuAs60c4cgZdtpuy0lqJUqhIfpiewNBLCmFsnNtUfXIk5e8kMnMRtFys4azTpYSkC3dMYg0uASEFmwA6XqImjMWGLIYal2pBaLUM4yqphpL+eRZTD41j2Zj/S4KDeGwxZyf7WkN0EVfrgNatCasdJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hWmxerz9GlRMWTTUxBhBsyg2E7A5CqwIPGeu12c3t8=;
 b=eGKelnG/rgGSBP3/vBM+adl/pp6gsi9RSpzsJqjefLW0ZI3fGNdw5npPMprodXlbDGvTkcpLm+67XMQVTLoxxFlvThO66JkJyyFbyTCsX7Ce3YcclkObh/3HzJ8RdIli3YQznlWmWrkFyBh9yKniZBX1RelJpsqcf8sL8vnTdak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB5466.namprd13.prod.outlook.com (2603:10b6:806:231::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 19:17:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 19:17:04 +0000
Date:   Thu, 29 Jun 2023 21:16:59 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] [v4] wifi: mwifiex: drop BUG_ON() from TX error
 handling
Message-ID: <ZJ3YqwppQ8cyd84l@corigine.com>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
 <20230629085115.180499-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629085115.180499-3-dmantipov@yandex.ru>
X-ClientProxiedBy: AS4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: f2747703-e137-4a9c-2ff5-08db78d56c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Mjy0uPxHgItMdm7h3Yf0ovAZXHYmc7ZnNhWGc5hBwKQ+GZh9MxZeR7IoWpeVCiU/gitZDUIP3uhPyB3Lt+3p7qy2HCCTL+cmZ81lt/Kn9k1Ej+mLRaUtpskCobdfTAMvj7QkDGoMxUMVU9TBNTLl1fQjixV+nOVPMJY2tfE1D/bgqBO5zgXk/LTfUstZRsga00kfMOSLvHFabzUe9WNw0/q5k4kV+HrkX5kRwZYsQSKu0oddeeo0DUILUAnzimxOCxKH3ANxBzWhZh+DcYaOv0xc4VjOK8v8i6M/mczrO9BqtcJzpQW3Ljf/DWex6yRnrb7CBGgVwQdjf77d0CXXG5GpOIPz9N2CqyzDweClZqxRhTQIKhl8RBKDBDWoHwel02RYvSlFmBxgCNIcWgHXqx2r3cajb+Qsh0TwKX74BXPNK7kWUdU3zSoLDTHH4Yeok9tBZXkvNXRcc3NtB2CqVg8O0bzt4cBjGDmKNmIu9sHivbA+waplQQNrHg8C1YHOVZYVfnyaq1veY0qdLCu74f02Y+QQemwr4ejCKIeAFLkB0lyEqEtTbhFRDcum99sDIY2wZ4v058A0wA6w6kk9s3wlFEkP4wqvHssgeLUfHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39830400003)(136003)(346002)(376002)(451199021)(6512007)(36756003)(5660300002)(86362001)(44832011)(41300700001)(66946007)(6916009)(8936002)(66476007)(8676002)(316002)(4326008)(66556008)(38100700002)(478600001)(6486002)(2906002)(4744005)(6506007)(54906003)(186003)(2616005)(26005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCp+/7OJ/miXtMXKO10fnSXCKq+s35pKMxS8tNr3uNlA9HXYx09Gebl9BsEb?=
 =?us-ascii?Q?EbKEBwegsEuDJlVqZGnq+HPcU1Yf6rZO8m5OzvplP6a/XpkH3OZ5eArg8xt9?=
 =?us-ascii?Q?XsofJ9CNkFYLrT+gok0N3iBfZCCGWFbKJCbGekCFtWbFeHRRXV4uKpCGsGZB?=
 =?us-ascii?Q?ZVfLjQRg+ECzvNk5GzTYSvWwqWI1xrnjLw6pj/drbPqOV6/tPHT72cOnFNtA?=
 =?us-ascii?Q?Qk10/MZ6syU6LUNDHen/fhBALghZtUBhbVUZrZzhl9JZ9RnZhed4f1Gt2Dxe?=
 =?us-ascii?Q?TlQooY6c0fUnhmqrNMp/05NbTukcSdCaP8oh+N1pYAer0GIYrjkcUp4RTEt6?=
 =?us-ascii?Q?7fQDXwmXZjZJOuq+rptgyojBH7VHcj25zxr0BQ+XUYK76+1eXYakj3ni/Dsc?=
 =?us-ascii?Q?lFjeVew9MRUuCyVMu1rV4eDvpCGTcPfgEd9Ovju4VVyiYABzvUCvv84kiB0v?=
 =?us-ascii?Q?kLglvx5U/qfGPev5IgqUe9X5M94CTh2SBZOe1Z6DX3jlFJFUUBYkykWenRHY?=
 =?us-ascii?Q?uSfgk5WDoDTt+efUeoXkP7MfxQZHcPJWxvGZ+hJPn7ROeVkG4hQKwVN+W33K?=
 =?us-ascii?Q?B/8Gg+3fqSAYRPSzx8dBW6X8WyVJPTJuF4kNRLhXuXL0HFu17+p7lSwG864T?=
 =?us-ascii?Q?lkBu7n82dN12DsQSefGyUOldDjGeJXXwjrynBFSMIUR0KDJrM4CnUEJFwQnE?=
 =?us-ascii?Q?SdHQiDW4cswO5/s8X8dl4LBSTARnWXmS/OjJ6VcCVqifKIuV4hjQMJ3nLqYk?=
 =?us-ascii?Q?Lqb0J7uA3nf8DJOwgUtn/9ohfiLfjLDk65eAuPDkwaUcBZw0WhyMJsGDa5o+?=
 =?us-ascii?Q?nqNDckqGSnqABEDJ0dfX3LanGx1U7nOhNVH4nS0+Zydv98hRtSnNTutGYp7X?=
 =?us-ascii?Q?HvaZVHpCuhB1G6csG2vBFBFP69aicznKbWxE3N3yo3azEx4LnyEfSfmc9YSI?=
 =?us-ascii?Q?qCRtpHh+iypjLVD+L03trOBtqUxj5jBjqDwDVtuDy8QX1+Caupm5t+2vdso+?=
 =?us-ascii?Q?tW8dPDprkFAvYyFHueVoRBqOcfyXwfeyRjbnMrOvceBgXpWNNCz/xNg89A1J?=
 =?us-ascii?Q?Tu70hMwJNyOZNddorCBicid+/bKC+7UeE8MNB5Ha5VWVeM5EwXMuHm8PeFk6?=
 =?us-ascii?Q?d8aCDIWWZhl/4N4pcmJX0tFF+SoHLPe1CyafN3ID3yJ/GufhstA6zQUWWCGX?=
 =?us-ascii?Q?5e7GMLvaA/rWO4K+yKSeBr4Lb3TJUoGT7lrn9sMYE1J7ZfSV2E+Hzi83ZMJI?=
 =?us-ascii?Q?xkCqH6EPM7cyz4oDYhcSCjHQNhNWB6ALwoL4sFjORwd9JPMtcsNi1WQ9JD6M?=
 =?us-ascii?Q?4mEDgqU3dVITtvQr2S7wX38PNPokPugYGmwmbHaJ0hsoRDyPe9PmwlA8ylA0?=
 =?us-ascii?Q?BbI7Ac0+t2/nMbXqWHRGgSXwJ1fJlfdH1rpdskWInbnmEllKXQsXIhQA5tC6?=
 =?us-ascii?Q?lnRnIQTig1+AsT8rtgay5fOj29VYJOsQHPZdQdph0chPXSG4TGq/E8w6nWav?=
 =?us-ascii?Q?CKfbilHwOLU3E2kryOUrm0Olo1vC05Bn1oktpemY47SZUw9Nr7NoQXeqgFYE?=
 =?us-ascii?Q?aeblG+a3GK4WruHxq/AlufjNep1KAUnS0oIZQWZ9t0M7EoMIsaywyJz38djf?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2747703-e137-4a9c-2ff5-08db78d56c68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:17:04.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLCwBxJuO3YJwUV2rPJXPzmSXwvPjV1jreK5wz99Ze2POyRUx0WtQEZcVbCAAf2yK7AY0XyUbO5OcBF8Zw1E3FOAiMw0Rr6HejcODPSYwvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5466
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 29, 2023 at 11:51:02AM +0300, Dmitry Antipov wrote:
> Remove 'BUG_ON()' from 'mwifiex_process_sta_txpd()' and
> 'mwifiex_process_uap_txpd()'. In case of insufficient
> headrom, issue warning and return NULL, which should be

Hi Dimitry,

a minor nit courtesy of checkpatch.pl --codespell: headrom -> headroom

...

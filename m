Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF6705179
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjEPPD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjEPPD4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 11:03:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7867A9B
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 08:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsvR3jpo8prTzICQVLP24tNeC3mOSxjMF6D9mHZxiLMxEdjz2VFUri1NZz53bjkTcfuu4UMo/di/c4C3S6BUJ+iqHelHamSgW9gMLqZ0ZFW6EOUybF9YrpYHEL+7vBD1+qbz5pnYSvAb0NGnmtR/Fmq26JlFHvKeFDo3VUUVpB1r6NetKzSOxDijCmKywRyeevqGkp5doDHT7CbkOqbmWDntmVvTlog090cxMuLOc0+hVtJNmLVi2p/Mfm1GWyuOqeOZcONa9FQaIEIqy7vM70i2+yXsQQV8FpLadYbZWKGR+TNmgW/nBjiy9eZTsOEv0C9WZyU2iR5vkeKTnFrPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op/Qjyuk8NguNh4OzxTKEojaPdHn9YZWL38Ozo23QCc=;
 b=Hz6KSDGicnvDN9ulxttBli67tqatzhEGh0J8yQeSEF+W1HeeiFPawNCFQZZ8zb8ZUQS+Nl/CwxXbnZTIuYnWRLc2hcjr63HwO83kGYCBIfR3P6KPfHsCpUTdap8xL5bA/s29soD19zn6Ef50zUHlXD1jjpRotQp/wHsTBUXsWhictmUdLmb8D6b+KVh77eA2Gi0Jhu9jV35wb3GzVdfT2QunHmP82wd9e8c4JKaLURTnY5Yws3Hgrd31iOdDmHbmTbz6v2kb6y2HrsMVm164ZcSudpU8FMsim9ETkxZ4sVnslBVoQr432e13wS9kH4byOaGU2ifT1Yu6MAruz3KSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op/Qjyuk8NguNh4OzxTKEojaPdHn9YZWL38Ozo23QCc=;
 b=ZZZn+OpPc15r243udf9qK8aq+NXtQOp/XiIkJawTX+IBphugS5QzxSVeK9y7zbW2g2XhOjaVFYkj+gtbLp4JERB8hz3N2+uEuZUy79JcJVZxoPdfaP15Pdo3pgbDpQkagP7C4VFKymRaO/m5RRM1NUs3IFnlAvcX1jSe6H1aR7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3851.namprd13.prod.outlook.com (2603:10b6:5:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 15:03:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:03:41 +0000
Date:   Tue, 16 May 2023 17:03:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
Message-ID: <ZGObRnD5xhmHmRTs@corigine.com>
References: <cover.1683930235.git.lorenzo@kernel.org>
 <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM0PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:208:122::43) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: a29e9273-7ea8-4643-0f01-08db561ebc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1po3I5stZM5vxZUl5D0lC4kmATOMshgHTkTfZSRpbNpD9VrRvbmNmYGBkON9iir2BW2kmze1DAyzS3s0TXZOlRp5BLHnucHJsOvrC9Fvk0pXX0eDcXmLIzaXpjyhT7pbWoMdMaPo/cLBtpciBgbl7RkWjx3WJG/kH8L6KyKmaBS39yWvf38TAr8zK3nhVYmTshFA1ifPlZMJ4MQvIUX0Lxy20gtbwG/bQ0SqjjUs8Vdv8Gn3Z7xUdfDkM+4f6tMF+BYqvkO1O9qCa7g1BbSowY/oMx3OqYbvQXvd4kC+uOi4rcEiNpPRsv+JxyGH5tRE80N+puVfJfUF7i8bf6SBdRd1dedSMjjsLJjC5MwYcdF1gnOYmuDUjuPyeLjR/Ei6MjE/Wf/M4kbJ5peLVQA9jS5bkLYVJfGJN1VCpNEw2Srq9agHi0D8sWybY2vmWv5deA9Zzcq0GEzC7PZKFS5k2/vecReCiqIyGvKl6DjdIYwh/22Qsb+RfUeU57u6dE5oKNE1TyGF3nfqVmy6f/84ySDtoA/c1kgv5ybgzrVBS5s7BizMCZ94qV2k/hitgkofZ7/UDbkdvuOn6tqvyHJldf8J3pP3aPHklFyl7zGiLsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39840400004)(376002)(136003)(451199021)(5660300002)(8676002)(8936002)(44832011)(2616005)(6512007)(6506007)(38100700002)(186003)(478600001)(6666004)(6486002)(558084003)(41300700001)(316002)(66556008)(66946007)(66476007)(86362001)(6916009)(4326008)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4j5qiSdJ/E7aahnAYgnoyr9//9Ig4FfgOjyRnpmte8ZytzEfGaaTzNL91vQT?=
 =?us-ascii?Q?eKpDhj6XTK18MfI2JAfk6/p7f52j/aOyD3BYBcT4hhWe7N9cSzwHQVl3s8Qq?=
 =?us-ascii?Q?fHwTO0iUu/DZtW247GjVIfxo63c0kjrWObS5dByk8ltaeoDaCDBPI8P2vn2v?=
 =?us-ascii?Q?av7wXMGYcDZa1h22OJU2qqe/f1Du7a2kjSxk/2gL2WY+SBovp0HOQVhaa0K3?=
 =?us-ascii?Q?RwxMaONZcJQ/ucPLnPej0OPCf8zTYDOUj894yUQcm03cCsZ/CT08gVG/024p?=
 =?us-ascii?Q?MOCD8HOFHa9C2TrzEdTJDuI3pKbdEte+Z8rAn3AClXHCB89qFF0EPakrvnXZ?=
 =?us-ascii?Q?bWgtAmNaoRipEOPH4gvC3em5eLS4THLJeSarvHdothTQaBkE4w/JcHHp1VB3?=
 =?us-ascii?Q?KbroK7Ion7LNUXaOSUxD0t5odYvqFJgBRoKG8FiFreVDgNTBgS7sseyjd1wi?=
 =?us-ascii?Q?wOTGFIgLFRiFGUcAWmsjmlM3a/SJRS4lpxTJSwU4ZftqqmvYhkzfypOtldxX?=
 =?us-ascii?Q?sajpzrmuZ5wt2mB1JYJ9YUfP7Ts1QVI07V7ApQFptfo4sddAbwq2PkCi2Hpk?=
 =?us-ascii?Q?N4fMyXggL1xE005gNVVZhwnRJ/wmf6j0kVIxBmg4MjA4UMbnFv4yQQik/2f/?=
 =?us-ascii?Q?YFVDxcc/P3irQUxHz+9eE726Rk0zOXVED1wLTYNUHLXRej2rijs9A74k7yJF?=
 =?us-ascii?Q?tqcUXysR1HPY0bk32w1UwKaBXZLba0ZXmHDHjsZLXJAqLgxd5bByLuhDMB7G?=
 =?us-ascii?Q?d3qTlAP97RaQplm9/tXKglpFp6zmUugQ52TizW21JCTOfxd6xTOuXusDS8QR?=
 =?us-ascii?Q?8NGG1Oaeiu8OzXDvywfpPqJDovXNzaCSv7Y7H15ErFRwKO/6rzqYr6GarIQF?=
 =?us-ascii?Q?b3RQA7k93kkmyEJUK40V5t+EfMlSqH2YsTpu3IhkfTD+O3nNQMBI2XuwryqP?=
 =?us-ascii?Q?195buAxP1Eyh0GDdDtg+7EAbCBcADftIp9tszKLzaPLJR0PpYvcWG8WiXOmY?=
 =?us-ascii?Q?iQsoCF7WZUsSAXs1cH7PY7zvZ0tt1T46YdNChMUO/zrIHPgvsEWU8OnZl2OS?=
 =?us-ascii?Q?QMuArwHAhTv+vjQo1G9MvyxEIbove9qGxshMwbR65Wb9cgj3JNJg/opL5tYA?=
 =?us-ascii?Q?+5wU1KPwcHXL0sfE5t7+q16dUoeU9wJXn02Kup/pKiDguPNFDW+vIIlg4DDt?=
 =?us-ascii?Q?whTmc7toy5asfN2dutTUqD37Jer+FUzOzXKy00lkyBD1LdgYBax0t/8o3eLa?=
 =?us-ascii?Q?77kapuoSX9HbemWeSy8ZcqML05t6d42PyO5sKx4OQjKDsA/TfXiCBurgqSht?=
 =?us-ascii?Q?sn+zVHNgTmxUM0fRFPwTX7WDYoKAkxls7jzwGwGem8Zncwd+hnEO2OsZFGzH?=
 =?us-ascii?Q?bU+aUOmxwr37LigpfaG+i37hraakSMz4GxdWZXl4sU19l2bMtqvcuyPHWnuq?=
 =?us-ascii?Q?qlnDrq9GX2jkblTq8Av+Ad0itS/d2BNN+iwEtJFkIsC//cSdDZ5OViwQa/cg?=
 =?us-ascii?Q?8zutCgrRlbQYvbjd2L2OpBfBUdAz1mGLU5RQ56ktz6OHeSVu9NVj98VJDJVJ?=
 =?us-ascii?Q?qjRIN1P0oQxrlpgJ8qX/AfxA11ro3Cyw6E9qaHIYG6SMHV2/+mo+hGi4fOh4?=
 =?us-ascii?Q?dTX+Tl6KrlBWwFyH/+QwWnBtDuY7+DzhH+W1aFToj/ljP63yfDRfjoxahoTe?=
 =?us-ascii?Q?+q/+cg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e9273-7ea8-4643-0f01-08db561ebc17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:03:40.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDeqspmtDG9aXlc40YxVyr/ALCxd8WAumYp/PShFArQy6Ho3H/5CJ1PLmlmznr1Wr0OC0PQkmAUSKz9H6zWYwEfRFA6YoJYeyvWuCUZ3M74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 13, 2023 at 12:29:53AM +0200, Lorenzo Bianconi wrote:
> mib_stats structure is shared by mostly all chipsets. Move it to shared
> code.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


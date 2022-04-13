Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6484FF9DF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiDMPVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiDMPVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 11:21:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BF3055A
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 08:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/ttoXYc6eT4wOe41X5Ykg/QTRljNyJtasN0Q0LAZRVspx64jkV1Mjf/AM6l669yMGsun+kg6n867wQVcRLkQr8K3AjHITYyEktxeF4EisOX1YIAQ6hKPkQvQrz5b659dhcrGaH9XYqKmlXyJ/uVJBJLj/hnT42lYRo8/kGS3SWmJVRcwvOFiwXdpW9cy8//30TvlZzhWrcvcmFRAbVCFM7dxan/pc3UUkjeJUPHUhhje+zsyTPE33yFFWBnmRf6jd2sx3Shn/XstTWB96/f1mvLK4osuOSsktGb1ZEk8aWKXF+Sq/Xvm0T492cz21iyGRtxoyNB/An47QlgplAYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4xeR8ORbNdsXl5zgwR2/uIuV4VLNNFVoqsTcF0bk5U=;
 b=Qm8SNTvHfTe9Rbf1GLWVtpFOExDRO7O482bPwvWBjSowtn8iPiOPZitoGJIGRqf74Qm7LxGHdZe7JrYOFB94YCYiKII3TIA0aJDeRxQQx6pYVD0X0Cz4CITD2uUAf0k9NCjqgJ54fY6FDYLFqcUQ/l7MgGbkZ/EIAJM7GEXC1niMYQpDm0mvCGOHKXpFs6mBxAGtq2V72GurERedMg3/38Pwlr70oooKPrikBV6mfnmfBja3Kvaq9AumXx5t1dEkzjbRY+aNoQXF7kpkXPWafl0qHv9hsbtpqKTALKc7h86rIhCDDfZ+4TK8EgIaaecWt7qmDpckBQSZmxSuD52DJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4xeR8ORbNdsXl5zgwR2/uIuV4VLNNFVoqsTcF0bk5U=;
 b=JlikGIiT6ClZxObhJzC46dz+7VXIgkSMOoOdGtpi+kY39XIWtgPsblA/1rC5UR/yto9ZlI+J1Z/jW9wK040XOyN2sDre+L5AKo1WsoZ+AntOVLL7acq1g6REDClSZG5w6A73IS3Y6LA8ayRau2UcWZcv8pibdiZAARbaDiTPDTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by BYAPR11MB2613.namprd11.prod.outlook.com (2603:10b6:a02:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 15:18:57 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 15:18:56 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 09/10] staging: wfx: ensure HIF request has been sent before polling
Date:   Wed, 13 Apr 2022 17:18:52 +0200
Message-ID: <4557835.LvFx2qVVIh@pc-42>
Organization: Silicon Labs
In-Reply-To: <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com> <20220225112405.355599-10-Jerome.Pouiller@silabs.com> <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e1500e-c226-4048-3740-08da1d60ed49
X-MS-TrafficTypeDiagnostic: BYAPR11MB2613:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB261376963D07E630D209269C93EC9@BYAPR11MB2613.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNB9GMPS0GYKXLeMD/g8adUQu5siGzfriXHG8BuRBE/xfUVAd9PFV0WNYMn0CG0e+nI3f92DWxm8T9NrFvAxh04GfRtrb18Wdce6RVjlMpPwW3qor5QgMQwwhXfKGV92g1dAph0pgGvV8rNZivU3o59aBDuDmrLbVAL9hDPobX3fyHxtuGVmgyi0Zns7hrccps+/o16SoMkKbq5Vy3AIYawYEGffmAAZzeicuM9ZjsdjpfOkk3EtjFQchiaX888VYyaWVnvejG7R6DE+1QeDUQbRCjcvui+V9FWQpGY5YGNWktgOe+iQPUy3CEMMPPQoqijl7I4xKf798sRAVoRlxkFiK0qNk/kXYU17ww+x34VH4Nf5Rib5KSbLIKffANovQ7SCAo1pAL7V5Y8L/IMMXA0QsjylcAgSdGljNonLTkZmOFlZgLMO6Zt28j6Aef+XxqVKPyrcLB9mpraP5SqE1Db1pUDQeZDqYGOOihTdplMzY/6uJCIQQuCPSLDpQ+pyw9aiKiGV1Z8nIq8Y5E0Dt7x5fXXNIx4+XS5gU9PjTSDV0FGkqdMbpZrYBem9kd+gG9FFTJDuCXw0LQUUE1QYDfaDr8y7hUWYLQQe6QLMZeBnya7vrXSR+wY0dmu4Hg5ecYsPjiJ3nEocU0qpW3bZuMXp/yh/CXM3EAGcKOn0f2C6otYd4jtK3FstoVjJCSiHl8mIxvhumhJIwlH1XOhFSMEG8Y6+j7/W0oTZPbPoG7TVSReTl9RptvO6eXTE78nKUt79C0hVJgEzN+NTzDtYng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(110136005)(8936002)(6512007)(186003)(6506007)(36916002)(9686003)(6486002)(966005)(52116002)(66574015)(316002)(4744005)(508600001)(6666004)(5660300002)(83380400001)(33716001)(86362001)(38100700002)(8676002)(66556008)(66946007)(66476007)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wl6H4hbYwsz4H4xJNn9vSZ9KB9RB0EPY9DUA9scg5UoUdgmFiEXAVaDZHl?=
 =?iso-8859-1?Q?g0dMjISMRWMa0nJnIdbs6iTsAGMncgg+7RHxph3vR9fov8g7DofJ8EkfqO?=
 =?iso-8859-1?Q?rue5bQdNgX8BmPpfSn8UNU10o86SVD3oP72G0Grprsv0iEQxvRXfph8tGS?=
 =?iso-8859-1?Q?fmtXkirWKw5kpAs9iYWiwMMA9IhrkY7e0ndNTdv4d/o43EvQP+ueXOYfli?=
 =?iso-8859-1?Q?jcQedaJ2m91OvHi+MP5/N2B7FVNHw1kYN/dog0pD9HwUv3oH2PH1gadH9J?=
 =?iso-8859-1?Q?D64dUDCpp3pwsM6BlAZVn7mQWlrKgiUhkdRA/fq5kX0oY5ZxtoTEwLEw0B?=
 =?iso-8859-1?Q?lrExdAZmMH3LiT05rBI6dW4nCr6oH0jjhG52OIfS0nzQy1/1EsaX1dOaxu?=
 =?iso-8859-1?Q?PVp04GMa9oj27xhe2aVZD/jsZC3xqrCWcKqfB0LIjmP175X5bigF70L8JD?=
 =?iso-8859-1?Q?ElHB638seTQ5aqG0oNSHIuEDFRHwamFxre5lqRHpUqHFDr8XS3FG0ZItp+?=
 =?iso-8859-1?Q?SddgEUVpXdmqtt2Qo1airUZUSNvcr01x6Vhco+rFiOX77EbEA7RK9JcJLn?=
 =?iso-8859-1?Q?lt71tcSDkLKOUkh+opel8hOR24boR0aOVZQQhgHO3wxmUXZFUQpS0qSyIj?=
 =?iso-8859-1?Q?hQkdMezPssX0JODWm59e3e5fIN5nHZwNGai5GQkghj9cZbRJJFNHAxNx5t?=
 =?iso-8859-1?Q?JieD6iQ6cNkpmC96yQXqRgBd7amIHgydoVgT9xbzmYyo8N005sOM7Iy5Qn?=
 =?iso-8859-1?Q?1tzPRfo6nx7KbH1hYZGsbhKJysx5FSFdYq/Nvb2dnYfkcXb7ZWIOkiCn5g?=
 =?iso-8859-1?Q?noxsSkNOa49c+O7gJ3wUOaFcFBaDdpdTiAgzmsCXyc9hDY3Jge+/H8RiWo?=
 =?iso-8859-1?Q?rtz8xfX/cvAemLcjKP/YB30bmH1EwogNJmJVPQxFzadYnQwH72LdysJLKS?=
 =?iso-8859-1?Q?rsEVPWJs85iWC1S+RYxBinzVj8/LMzciI4vcJ+/RP3CyXBLuxmkZlKiHZM?=
 =?iso-8859-1?Q?QjyChMzrm75vOuzmgfR91LQCB0oCcg/iF2oiyYgCa4FLwMjoSRkUMOvNRa?=
 =?iso-8859-1?Q?bESYxN2P0URbmsCPWMJbsa1jBaeyBrwhgAZteysyYtaAPLyP/Gx0GpfYFh?=
 =?iso-8859-1?Q?Kh36XBNt/AXz7MtKQ+mC6RoYSisxtwGX81IIUUBzN0qosTBoucpScCVNuK?=
 =?iso-8859-1?Q?AsjIICHoXC7fCC8+XIvSeczBxHjaiL0yAz2Ju/ZzGP7Jr5Uk0UbijOr0Ta?=
 =?iso-8859-1?Q?dQYnWpZN87ewoDsHiLpISHbTDuuqDLpTBhkTZ5PScghInEvz5fYYHJgqvB?=
 =?iso-8859-1?Q?efj6MYlGtxnkQvi65KgfXzCsFfrVWVSSn6aq+CaBNcrFjjKLrKqJOIxfDK?=
 =?iso-8859-1?Q?RggPXZ0uWYG8UdHDiTcUyJ/TQPZskzuLeiQFvY5lX1F0xJo3e+f/XfEbIO?=
 =?iso-8859-1?Q?FzaH1vyIC88S6tYnVtj9mRazbXIYs4fnLN5G3B7dUWN3vNJ6hxzsQxupB+?=
 =?iso-8859-1?Q?PNzuoRDvJJZeFlIlzn7Y2QCUq6rus3ss8qoFnKNFFoQSBrDISu2DBPLHTO?=
 =?iso-8859-1?Q?zcXUbRN9sy08AjN/Lfhrj+iYldiuVerYkhp/3n8bbg63q6b3DesGzUJ2uL?=
 =?iso-8859-1?Q?v9iC3PB2tJtxv+kwDcEPh12aJA6Su7nxzd3aP8W2WFJUDU8IX6/lGqkwDd?=
 =?iso-8859-1?Q?7FFupz3y8ngrHKxWNlnW49rQBtJ1WNx9lgGM0uaNe4oKbi8vsssorrpIwt?=
 =?iso-8859-1?Q?/sID5FQp4p20eNJXC6uzvLm+mg8fZyjJerKD7EPhpSxM05rtOo4t0RxKZh?=
 =?iso-8859-1?Q?hnQN8RhvDT90e3OiPeiX1muyWCoSg1rQuB13YGOAPQLXCEI9v+Bm6PbURa?=
 =?iso-8859-1?Q?3T?=
X-MS-Exchange-AntiSpam-MessageData-1: ZstJgjF+DvY0Wg==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e1500e-c226-4048-3740-08da1d60ed49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 15:18:56.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVjeVCbfN8tHdnCGoH30hM3MqWWZ6WZ3byY2t7j3UP7pAWvfAM/BXLY01qOoevmC7V12WAHaGNEVeMYJtTEv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday 12 April 2022 15:11:53 CEST Tetsuo Handa wrote:
> Hello.
>=20
> I found that commit c86176d51340d5ee ("staging: wfx: ensure HIF request h=
as
> been sent before polling") started using flush_workqueue(system_highpri_w=
q).
>=20
> But please avoid flushing system-wide workqueues, for
> flushing system-wide workqueues is dangerous and will be forbidden.
>=20
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-lo=
ve.SAKURA.ne.jp
>=20
>=20

There is a workqueue provided by mac80211. But I am not sure it can=20
replace the system-wide workqueue.

I guess I need to declare a new workqueue. Give me a couple of weeks to
prepare a patch.


--=20
J=E9r=F4me Pouiller




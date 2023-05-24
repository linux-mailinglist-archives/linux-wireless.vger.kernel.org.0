Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5A70F563
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEXLfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 07:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjEXLfC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 07:35:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE812E
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 04:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWQTmnMgbn/SeOIVa39c3SUJo+M6SamIdidhMz/v6Ja/A5CRTnZeIyfqeCzsbiPuXduJJkvZD845TJJs+JRjyk+aTJyW+mTcvRunmIPPQNkfnwYgue/8peTBej2KjmwVNVxSYYqTYrRHsQmidgny+IeVKIF/dgtobWfPGYwJqROHJHB9ttkEp/kJORXsGKBHNSRi7kltYYORyuvotBX4YuGnLlrxt+b8DSP7iHL9IHHtBZX3JQ7GFVPdk+0wRUG5nYlupFQq6A6e4dQPEodUddoOzwJF1u4jgDidNkfrHkzwT/i+MyC8hLzmWbKJnzE+Gfodnfx+gzM79yH82cTNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCD5GkAdPF0aKyBbnmFlfrM/9DaMDtc9kTK+4RJao5k=;
 b=GvRR8DIKl/HXtKVefMJtEp2cEloITm1Lvpf/IL8VphPHkuvRmw/6TVFkXPpETp8gIIvvqjDujVT3BOrTH9LwCVrt1dKBjz1iSFD0QPgvoX7kB5Ul76s5XFSGep59sypmvcwEEcsr0jOUvJIYiJ9Ye7rpc3NOErI3tcHcfZ2Azs+MlZp3eNlDIIpi/ijQG2hD4/FzUUzT7IBqlj+jbqYebm0fKoFO/bHuGSeX8OtpVMR/PCgS4hq5golGtrIRBGEvvN0vRR+5uSWJ/uPrqg2AJAuy3YLKAZp3Xfp2bXsMKEQysxzbXg98widMkAVH9NIvxnzn/+5j/mTTaziAml4dXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCD5GkAdPF0aKyBbnmFlfrM/9DaMDtc9kTK+4RJao5k=;
 b=CDr49GVtSuXIcOzmkBL+33pQ9E3We55Fa9NfugKXJuyRkOIB/Jlh+XaJ8u8jkyBnL2eLx6uAauV0wMV6my21g3vKCoiKk2D2tWLUMTe4miHykL15fZLJSx8Jpexj83aCYQH4gPM1pYAJK/6S+K64mi8S0RW9Lry450U2OebxiLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB5516.namprd13.prod.outlook.com (2603:10b6:806:233::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 11:34:59 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 11:34:59 +0000
Date:   Wed, 24 May 2023 13:34:52 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>, Tim K <tpkuester@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>, kernel@pengutronix.de,
        petter@technux.se
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
Message-ID: <ZG32XKBsAub+Y+bO@corigine.com>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524103934.1019096-1-s.hauer@pengutronix.de>
X-ClientProxiedBy: AM3PR05CA0110.eurprd05.prod.outlook.com
 (2603:10a6:207:2::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc1f238-8f2b-4005-fc0c-08db5c4ae7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6GUWFtXo16NvWfrGJb37CpSz7S/ofWFdME48ph5L1jhKqgbJ5AFaELwcbj5TkB57+j5u/6J5BQokxQPXf+O+Y50V3+EuS17WE6L1XpyITZxaki3Z0KoPLewN+tmODdCD6NrcLtkBlS4/y9Jkpd/WgjVqh400pOFFdOuR2JFLoexj8hE47zxyQLk8Ktx3Dcy6z70HtFLxj3stg35dH9BQ1fDhbjhE5tDx3sic9fE0Rpw0fptkL0+YY+zJnqXv3YACGJq6m5A/Wo61EwrYHcMaodmvtOSvUxFwy22ql7FcHaH9P1QPLB6YPQaDbapDQ0IT5aK40ZgitZuprGBJlwh6C7qBsgUpbD9bO4NZzoh60hOc1LlEd9WJd0K8WHJvSx/q5iar2Io4pIP3zS3f9PRd/Zy+apvUnqC2Y8A0OYFCJc7AmtAI/fMFCkrtzQS0DCsK/LbYkV/55byO6TCDMmWOJN1njW/kOegAEg9i+6xe0VrE8GIFh4zvSZm5NCk6PEIZRFe6pVATu/Zx3yQO/uzNXn4ET5XMo9/g7+sTaP9+ZtaDqtYP2jQhYAZ4+cHTdE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199021)(66556008)(66476007)(41300700001)(66946007)(86362001)(15650500001)(5660300002)(4326008)(6916009)(316002)(44832011)(36756003)(2616005)(8676002)(8936002)(83380400001)(2906002)(7416002)(54906003)(478600001)(6512007)(6506007)(186003)(6486002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7WSYJVz9qUMetMBBjKxUz+bo5iThPCsUOLdtsRveEOrDq+GDSSH/B7KBAkuL?=
 =?us-ascii?Q?ArGtK+KJ1wMdQQe2YZS2z3x/4IeIrygfPP6TXF1hpqmfxH8+60EhHVzi3MGX?=
 =?us-ascii?Q?AwLd95P58CMNKabwVgLV6O6TgMy0lOJOksvnCPiAtfdiHTppXiRyxFQwhNc5?=
 =?us-ascii?Q?RIvZa97YmA0Nm36f2u3I1NMvpBtFeicWxqgJ46Vzp7JAEdXfJR4sl4tcX7RZ?=
 =?us-ascii?Q?3x9aSKqo059n1lRX9d6yriXlR9AusgyPwj6IgMsVNCLURJKoxW4G7YkFzAof?=
 =?us-ascii?Q?h43JcW+r8M42OxCM1BnGo4l6v92CdRZ7OJkYfTzFZtqJWRvwq56NDa1OX+T3?=
 =?us-ascii?Q?pbe9jux3Uc3q/DxM3sQJvRmXGH9c3/HlItiNEXJc9sAycDu6+NmQr2rsftnM?=
 =?us-ascii?Q?oNbr/Jj4KIpjRi+IAnHZueIsgfqw3m88wpRGTMbCXU5ZizQJgB5D5KXI7k8H?=
 =?us-ascii?Q?fn6yMg75hBgHeafdCH+yGtZwMJ0sHzlSpFM7Cih3VF8/zGmWwarE74xdb9rV?=
 =?us-ascii?Q?Gp9BCf+5K0B1WzxUcxpWgYHFDlFU9WGFy6i4isz3f5ICHoa7WD4s09Jena4I?=
 =?us-ascii?Q?chF+vT6dQdlQOiFXzn5GYQ3M1PpGVGkp0JnDL291QSPR9rZ54AMkFmWNLezp?=
 =?us-ascii?Q?aCHoEBQWvdd0hUIwhd74/2CPS2qXlpxMD9aGyrwuD8YTQDDw17HUr/1oxe9A?=
 =?us-ascii?Q?G8j2KkW7BEh22C4USwT608O4wj/ArrDu6WfAq1fXRuVlTHF8guVpl/aqMpuU?=
 =?us-ascii?Q?R9KJeBQp2BYUjzhsMwHY1lVGtLkkk4fK/M+FPou5VEtS2Xms9ulszkiZc9Ph?=
 =?us-ascii?Q?VjnIAcgs6xMNGD4aaT6neo4/PXB18cvFIiXjNRY/h2bysXDNUwDTPoI2rL4J?=
 =?us-ascii?Q?bHzNONNs0xjnWgU2eMgj7VdXAgqZO7LGQ9W1JXiQkPiB7u3FVUddmlT5bsf4?=
 =?us-ascii?Q?Rij4hONC4LLrl3a0FFIlcVKLA4mnijK2j+BRBdc9A50UBpDJyO+9hpdz3+sR?=
 =?us-ascii?Q?aoYQfqt6aeArudqTMuKiszvQ4XXdBy6M1yvrkITXpVspGkl36d5bGX92lQ6I?=
 =?us-ascii?Q?0fcsQV8EPQQYP9GmfhC16gt1ArXbfTfzOq6oYGfu+pO9uKH6kwbTBK1HQ/gJ?=
 =?us-ascii?Q?qf1u1R/mvzSLOvIQsLqw00qsKKtRju/1nIEDb+Cg3tP02EJO9l9DpAboGYgh?=
 =?us-ascii?Q?rvcnAmCmcLTU6skTk3VDyudUWRXhxg//1tRFI1U4xh0GgxRvubWewnQ0bfhn?=
 =?us-ascii?Q?iIvv6iF18GVYqhPZQA65fyHCleoHlBxCIndllW7yoy/3FNAVlsJ8jpM0fR/b?=
 =?us-ascii?Q?o5Hq5BXKry52KtL43OSeOH9lHgy0i4TVSA4iTKXi/Y0FGs2p0FtipY6ksnB5?=
 =?us-ascii?Q?0i9+lGEkUfGgZKdpHkCEdcPiV649sRPPBu0yg5Rqu0YjtukrO/ZO9P0xUcRO?=
 =?us-ascii?Q?eQBlVR1KmgaBGQVgUQfBcIuZUWffmJQ+9KymfBxVs/5/mTGaU4YjMpbzk0Z3?=
 =?us-ascii?Q?qCjiKmB5vYrt1cgMbfwO0H7dxBfc0tjzUijatC27Zs9HEby8GsQrkOTMqPlL?=
 =?us-ascii?Q?dG67+evmhHnDXwdo8nQA2p33a+S3lSBgAfk3NP3BdS1y0fKjSYQUGlC3EbGr?=
 =?us-ascii?Q?Q+MMcy590me3q4ZB8PsAeAa76KmsU8nhFEsv9PKLl3CGSUHu6Yo/LcChh71S?=
 =?us-ascii?Q?8ld55g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc1f238-8f2b-4005-fc0c-08db5c4ae7bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:34:59.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvYRSttN2IDgwXKw+5MQSN21tCTsiUskP62kNJ+tNBVLOOnWUwQpPP726VgZuBvS8hHqW58MogUSo0qxKYGQzvKpE5f3JkdLvyKOuoIL6t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 24, 2023 at 12:39:34PM +0200, Sascha Hauer wrote:
> When receiving more rx packets than the kernel can handle the driver
> drops the packets and issues an error message. This is bad for two
> reasons. The logs are flooded with myriads of messages, but then time
> consumed for printing messages in that critical code path brings down
> the device. After some time of excessive rx load the driver responds
> with:
> 
> rtw_8822cu 1-1:1.2: failed to get tx report from firmware
> rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> 
> The device stops working until being replugged.
> 
> Fix this by lowering the priority to debug level and also by
> ratelimiting it.
> 
> Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 44a5fafb99055..976eafa739a2d 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -535,7 +535,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>  		}
>  
>  		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
> -			rtw_err(rtwdev, "failed to get rx_queue, overflow\n");
> +			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");

This is certainly an improvement. But as I understand things
it is still somewhat verbose if the condition persists.
Did you consider dev_dbg_once()?

>  			dev_kfree_skb_any(skb);
>  			continue;
>  		}
> -- 
> 2.39.2
> 

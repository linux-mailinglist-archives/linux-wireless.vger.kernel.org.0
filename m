Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAA3691A7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242309AbhDWL6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 07:58:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:50747 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242296AbhDWL6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 07:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619179089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W90LeI5/tPgvBxgfzbi6eTkRqH+2BKWBgZ5YOu+SobA=;
        b=VKWA9PSWhkuZpXULZ1mIHk5y4IDgIC+cTNfKlnSfeQeVrYgaF6A8sUAIs6KC3Wz5PcZjyj
        kpmye7qoFq1hJA63VXx7VeMSWcd1sQOodw/e9LYq8dCEJ+dICRGKhbrO7lMks0SdTx++KM
        ZwicOTnbLv4ANHwK/2OA93uRgaURJIs=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-VkOLuI-lOLeR7tNYZr2Rhg-1;
 Fri, 23 Apr 2021 13:57:01 +0200
X-MC-Unique: VkOLuI-lOLeR7tNYZr2Rhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4IPP9lZgHIL9R2iEwsATIMWs2A6WWgtZV/G+seRbV52QLEQnDgzk6pzDG7tsk6fpSxF/uX1pKYU1qa7Hd08xyZDqrbxQg/usdZ1CMpLIGJNjMAvRg9V9igJGOi/vNCrdLD61xVt8cQ53lLbSwfZwhrdj0afwPfm1LnsSfBU4gwgJon64/UyPQ8JEBgXzmWNVGtUxTeREsRczmo468C/NA0qo2OwkJChM97AfyijegomIOpWorLQIHXRItGVqT7HbTDQZJGwqAjKXzBcdXFNcv7oE9nxKvcKL40PZJv0ArMDzgJ0QxjIfuKAGvAwzniCCimGONIh2fmnj244mlrxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W90LeI5/tPgvBxgfzbi6eTkRqH+2BKWBgZ5YOu+SobA=;
 b=Bw/EumLOs1NXcuYLf07uhtmZ2Q89CaGfKk7vxZ0bOnP8FHxVfjjGfeiR2IwAgBZlUeEbpWSIclb3qEV2y1173tXMnfbCg/vYLiIBRqnbecUUlcUGFe1sJAH/vZgxGSpJly9ttYM8k7Hmt4+907MIPqIl/X32DwtslfgBIN8pqPnRO5y3fB/sT8kl/9QQNsy0mWTUMRULK5j7eOKERh0VhU1SRoILKE0FFj0AFhVlAeJeEHqjwe0uoYCOdZ6BY40OQAlL3O2B7Kg0o4vOyMHC1Vyi2NSeuBJwBHmq/q2vVXxY4M+Seo6fMpv4cVUFRcGelIxGFj4A1L/KAXHV/s78oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB6037.eurprd04.prod.outlook.com (2603:10a6:20b:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 11:57:00 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::353e:83f8:ff3d:deb0]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::353e:83f8:ff3d:deb0%6]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 11:57:00 +0000
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
References: <YIKzmoMiTdToaIyP@mwanda>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <d433c141-5066-07c9-8ce8-d271cc70f287@suse.com>
Date:   Fri, 23 Apr 2021 13:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YIKzmoMiTdToaIyP@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM9P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 11:57:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4c055c-f527-4bbc-b58d-08d9064ee74c
X-MS-TrafficTypeDiagnostic: AM6PR04MB6037:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6037B7053F2ACFE4CA4615BEBA459@AM6PR04MB6037.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yUayMcDNWmiI35NcnqXbTLBrIYJv9C8yMM/Zk02RtdvdBoeBSQY4vwR5cz+zueMAomNGrpduK0/dzkGjTOcU8ckz4cdrniraBQbTzoQcBFssW7KGzxDAEZYBEB1VSKmms0En15vbUAGJ6dnPQ2bhsJxwt72e/l0lpKLeSFx/fuqbk17eblQL3PUyUNSBL3R398WWd0CvxJRFJ44ksS1G3UFKieBaxnfSweZ+3yMd58iotSnTnTpvmmXKBKx3JRy7WRQ2/I+bOfncHJz51lfdVUNhv0UMe4T/vhhkK5BYJ3Rf6f4G+02ZQ8Dr8vf6tvg2XX+RSiq6/LyXI/9yjhbA4aJnP0S1/G/2/yhKC7ggPGbL9CXfXV2Mly38aFAYQg+I5+o43yF98FMgm+k5cDEf0Ltc46NOVpqnqc97QMqJITS+LAVAyeSzwivqJ+NtjwDV4dRwXl9i1UkOZIv+kvP24AqXFs9hcggFEyoD3mRuapHgbp9/keRE94Kp4+01GYNNYKMYedmW+zLVgtD+n2mFup/spL5ppfwYEa/PeU/UldsPZSNwD286r/2xKNiQsYUecnWz3uiOKrPUnTLt47COfcRWsdivFImGZV6YvM5gDea1stzLYFZulgjXEdedtnEUc5Y/x33vL91q0C+RxeO2E9wLcK+WLCDpSyPGt6pn+p5Km9etQ07VIYPVmmyADqpPx3ybPZNsinY8oTYqwcNSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(478600001)(36756003)(956004)(316002)(2616005)(54906003)(110136005)(83380400001)(86362001)(53546011)(8676002)(52116002)(66556008)(4326008)(2906002)(186003)(16526019)(26005)(7416002)(8936002)(6512007)(66476007)(6486002)(38100700002)(6506007)(31686004)(38350700002)(66946007)(5660300002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjlrM0lEWGJDVkQrSWZiZ1c3a3FjNDlVczF6WW9tQWxGOEY5dktiRTJaNXNz?=
 =?utf-8?B?K1pqc0Z5akxjYUxIdzQyQnVKQzVjc3NITFFtSytiV1RLVGRlZHp2QVlWSmE2?=
 =?utf-8?B?U2JUd3BaRFFXOVBjZlA0ems1TUw1ejd6Z3M2eXVobFhhTDlUbkd3WWRGckV4?=
 =?utf-8?B?S2FTWHlFNnp0MUxkYlNiNmFRRU9yZ3hqV0Y5dzBqZHNnSVNlTWFLZXJncXo4?=
 =?utf-8?B?Mis2cmx4ZVE5elV6ODY3T2xRSVdUbVl1NS91aG01NXAxSWdZbXVzQk1mYmpj?=
 =?utf-8?B?ZzFXc1FtVHJBenNORzhQaGVDTWVQMmVZSmFocDY3OUVXSFcxaHhqTFZDcXdB?=
 =?utf-8?B?dEd6VHR0bXVnaDRyZnRlRjV2QnQweHVzaGtxcjFDdFRub2lXMVNEQVAxT0dO?=
 =?utf-8?B?LzQxMlNic3M0YkhKV1pQRlVnaHlPTTMwS2VEWERGbjE3M3g4UGVlOXVJNHcv?=
 =?utf-8?B?b2V3aHg4MkNlcDIyT1p5c0k0MURQUU1CVlFVSUVidnVjOFJ5V0JTL2ZTeUho?=
 =?utf-8?B?QzVWenF0eDNSTkdwT3FLSEZ5M2x6alp1V3hWbFFtOXlLYkFyd2tjK2Yxb2M1?=
 =?utf-8?B?RDZmTm1nS3pJMjlvczl3NnBxRnpFNEx3UU91THBGSk4xS2k4bDRYcWxGV2ph?=
 =?utf-8?B?QkdkM21xekNaaDJqSVJ4aEZqRnR3cVJzRWl4UXRKWTRzRUg4S1hucUFFM0t3?=
 =?utf-8?B?eC9TZldmOGdlWURvMmZYVzI5Qks1L0luNmJCeWNzbTk4V01XNUdHWHAwWnVD?=
 =?utf-8?B?akhvbGFVcnE3TVVxYitvNFJsaXFIQmlpNW0xTUJUQzV2dzB0UnpKTWNYMHpF?=
 =?utf-8?B?aVpXOEF1V3V4L2FZcnVCNll5TGVod3lKRmQwbENTZlNyRzgxWVppVFZJOEVH?=
 =?utf-8?B?dXdtYkRGWG4vVmFjZ1pSdWc3WVF6VHlXWDJ0NzU3TkVFU2NTSkR5LzVMbVpZ?=
 =?utf-8?B?U1BiS1l2MjFBTVJmTU1Kempyai9yUkQyUGpQM3pBb09rNm11emlJdlpEWmor?=
 =?utf-8?B?QThRTzlOWXdPWmJlN0NDVFgyVm42T3pnNDN1MGJvemQzSmF5WXpjUzMwN21D?=
 =?utf-8?B?MWJaYUZyOHZpQ2RodGt3V0FFV1FWT0RsSkpCY3c1Rk41b0JFb2oreENIQmVB?=
 =?utf-8?B?TjAyNWxkVnlmOGYrYVpqT2s1VUJSNFg3TEhyY2RGRGsrUmJ5WkVrTFVCb1Ny?=
 =?utf-8?B?b1VDcG5GSm5NN0M5akVtdjlkUTdBbWd6WHEzbnVtK1NFQ1dGWEJIMUJ3TG41?=
 =?utf-8?B?WEp1dHg3RWlEeStCaWM3YzhWMnJVbXpVRG5STG80VDMwU2h6MzNVeXFydGR5?=
 =?utf-8?B?YVNVdjZvTllFbE4zZGdZaEdhTFkwaHlxcE5TeVVqdU10aXBEVXVtT2JFMURl?=
 =?utf-8?B?VnJXbG5oQ3kwRGVHa1kvTngzSGhQZHloSW5SREsyTmJ2YXVsZElHZW55SEpK?=
 =?utf-8?B?TnRDSmpwWEJ5TUpwSGk2aHVuenBtY2JEbHdZNHZEMWZzQUgreFhoeStTaUkv?=
 =?utf-8?B?Zkh4RUlPcU5QUzdjU3dVWmRQVC9XREdFOWVXUTlIVUdDbXZmdisrdnBnOVhn?=
 =?utf-8?B?QWRtZFVBMGlpb0hmakhKQk90anV1azRSbVl4VlMzR2lUTjE4Y2hnRkhOb1Rk?=
 =?utf-8?B?dkxSK0F4bXdJNERNZ05ESXdlWVRnRlVqcE9ZTGlIUStNVzh3MElON3JZMElO?=
 =?utf-8?B?Z3R1VndVV3VEa0dEMVBEdGY0eHovNEMvMHdlS28yWWdZL1BvUHF3SnZ6L2Vp?=
 =?utf-8?Q?52Z4kA34VKnRzJbt6bTJW168M7oBEUrG6St+gMX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4c055c-f527-4bbc-b58d-08d9064ee74c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:57:00.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6hz6IcCjx0evFfdnPyi6cKAlWB2pCBjZsN6CXeF2wHCTU1CWEpiEbS1i+nVzPcVtZssGb8/mI6hh9PEauR/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6037
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 23/04/2021 13:46, Dan Carpenter wrote:
> This code is supposed to loop over the whole board_type[] string.  The
> current code kind of works just because ascii values start 97 and the
> string is likely shorter than that so it will break when we hit the NUL
> terminator.  But really the condition should be "i < len" instead of
> "i < board_type[i]".
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch, I actually have serious doubts about whatever I was thinking when
writing that line of code.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..9b75e396fc50 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  		len = strlen(tmp) + 1;
>  		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
>  		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> +		for (i = 0; i < len; i++) {
>  			if (board_type[i] == '/')
>  				board_type[i] = '-';
>  		}
> 


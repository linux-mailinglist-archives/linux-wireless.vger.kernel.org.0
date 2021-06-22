Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBE3B01E7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFVK6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 06:58:53 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:26850 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhFVK6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 06:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624359392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTEBEJ18ULqwuCxtj/TWkYY7hZ8vWaD/RwUmjF+oObU=;
        b=IZJ2vziXobMP2oGTTcCKermwIK26rT8CesCEAvYSG1Z+CLvCu6Qd/GPwDLMl4ljhVXHLlQ
        WMJsXFAuBf0CaeFnjSu2s6EC3G3sEm4u5lpPC6PtGqVS9JF+gexU8Y2wu6irOTs0Tpb7mE
        wvQ/N4Wl5Q1GwAChJAhVpYhOszUxep4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-qaLYbKThMBeT45FWKIuNqQ-1; Tue, 22 Jun 2021 12:56:31 +0200
X-MC-Unique: qaLYbKThMBeT45FWKIuNqQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp/EMRQjQTpu8lb0BfAytGr9Mk6lw1DF2robxKPdWiC1OHImSv3/QXbIMfpg+x0Hpp0xaYIPMUw67DdF3o1x9/gMVOM1Ef3ZzIlhVTjoFpqnD4GctkB15UrWS1Do9dFIbqNDnWLiWCbc5gF/moAAOy2NgL8Vp4pJ5O6KgYYm15gmsRr9KkOuBIYpz19NYQF0j5+qg1CdJ+sIfzeU0b7fivvQx9Fjkyib19iOAL8qtJiZYX8VCmtwH8PatnGlHjFonynp5Zqe6SVAzrOyFyRLKZBoOgS6r8sQFCOAlslBrqifJwxl2MCNv0IOOtw08kOFcOYFYbMNclNg7d3gldJXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEBEJ18ULqwuCxtj/TWkYY7hZ8vWaD/RwUmjF+oObU=;
 b=R8+5oRKWlJxEk2ynY/He3bcaJUqVsm0GU6eRpT8T2T/qr/AJ9YbGCAtn9hiprxKMOWPaNXBr1aASd3BIzLxvFxMq+09FI0uLD8eDcnNYWFMVIv1Yg4fFQH67f8y3NRJEFVb8frmCCnflRAPw+AbNvdRIkacOR3LVr5nFR20E2aUhKhbGyoPNTB7vkylGs76+kwk/DSBVHfs3D02f4g/w1qCQKKSTJf7AS1lQVkM/S1/z2UdQnGq5XxiUrI56xBsk/aRFlOYzRIOCEZ1seGhIPac23763Ze1P8llRPk15INZjFRaJLW0WJ4wRph1m7Bz6FqQciGLSTuPwctqHKsv2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB5606.eurprd04.prod.outlook.com (2603:10a6:20b:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 10:56:30 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::95f9:4fbc:20ff:2b8d]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::95f9:4fbc:20ff:2b8d%3]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:56:30 +0000
Subject: Re: [PATCH v3] brcmfmac: fix "board_type" in brcmf_of_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
References: <YNCHELb14+eNV94n@mwanda>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <742353ec-d25f-7913-ec84-68b7fa28868a@suse.com>
Date:   Tue, 22 Jun 2021 12:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <YNCHELb14+eNV94n@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM3PR07CA0122.eurprd07.prod.outlook.com
 (2603:10a6:207:7::32) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM3PR07CA0122.eurprd07.prod.outlook.com (2603:10a6:207:7::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 10:56:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd98a07-25e5-4508-a81b-08d9356c63e8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5606:
X-Microsoft-Antispam-PRVS: <AM6PR04MB56063C8D14CF7E7BF798920FBA099@AM6PR04MB5606.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGEQX8QVtXJu1RTDqt3QZO4rVJusczmc7II195uhm8utKYRB/spsFuGKKAd4MO8K+g6YiQbpi8BFxVyi4aD8lRo+W0CmbrexHxrqGvBfxywfzVZVACamcq4jWV4MP4B++I83RCzBlRFur4oULsl9hr18P00mC471DhvPHIqgYcnSI/IJlbukGSEczIwUoBxp9L1todrgB8GcO5nHwRQANKB4f2Tk5rBHEfiJ0U6HdswxEAwCxqezXL60r/g0wgkZsV5rvh5E4uG4Z/fgGVILDQUXPqaYIuQdgCiLFF45SI0Oz/5fzZDfF/vAZbuAGgSbbFtUI9WJNsMeBUOwk8ZcZikgWm9KCXpC8T7dp/WxCiXNdiNHSC2yM7Qvli0G6JXN+lZ3skiRXWkGIWDfA2+z1JW9SQhykna3B10PHNUgGp98rORs/mC1EwxI4fGmuUB5LIGwkpMsr6NVyF6KCPknZJvXwnuZeoZ6tj3HkB8kgyme9GZUcR71YY0yVBbsw9bNR7Mj+YeVmrY4y08X461No0lZd4P1L3jSg59vZWU131eduk/6+hYaL4lB5TEGFJJLEb35OWll7uyMHXcaMy2Pt5mRHMhHQp1NQSHLRLE2y1TMNkCVRhgH7Bf+A6SNfQsx3aHSXcI+lh5nGYtVUTzc+vHbEz2JQqm66F2Yzak1N6E+5h9/5LjcH13aDebzwD1aS4qdGZ8FlxiAs4SnMo3ngLSAHSggy1mDtrCInIJzmCCws1C8sdiB1l69o+D6g2ND
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(396003)(346002)(136003)(366004)(956004)(2616005)(66476007)(8936002)(66556008)(31686004)(66946007)(6506007)(2906002)(186003)(53546011)(478600001)(83380400001)(26005)(110136005)(4326008)(86362001)(54906003)(6486002)(316002)(6512007)(7416002)(16526019)(8676002)(36756003)(38100700002)(5660300002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzczV1FTaFNrZnpxdUFZZUR0ZWk0Nnk2bW4xZUZjckFubmhuYWViOCszN21u?=
 =?utf-8?B?TS80eEc0cDV1N2M5cjBEVWxSdnpkQXV0ZVdWVDVUait2aE9CUWI0L2dvTjRQ?=
 =?utf-8?B?YUNiVk9oT1NqY2tnbmtJaGNOSjI0NloyREtMVmgrVWVqZmdCRldvdXJCeDQx?=
 =?utf-8?B?akdFZUtEblFhc2VVaGk2SkloMUM5OXVjL0ZYTVpHN2hvQldXNFlvbHRZdEtP?=
 =?utf-8?B?WFFDcWhQY1ovQS8vQWRWTUo0R3JHM2RKbjB2MERTTzFPa0hHUFJMaWo3RjJt?=
 =?utf-8?B?c2FSK2Mwdnk1RDFDbktROVArSVI4aTZiSlhYK0tDWjhRQzN5REk1VFpXRGRt?=
 =?utf-8?B?RGt5bmx3QlV4MDRJanVNc3BRaTlBZUJ4c2t3N0Q0NnUxTDVxQk5ZQVBZNklV?=
 =?utf-8?B?dytsMnJ3RndPUlRkQjArNXBCU1FRT2wrMVlMOVVjenZBdUx6aFhJOXRzQW5s?=
 =?utf-8?B?RUJ6Z05yeTBDdCtUU2t2eCt3VFd5VmVzVnpxRUtlanBEYjVNSWFaWk9IVEpv?=
 =?utf-8?B?VTBMR1Y3Q0NYVUdiSTlFdkVxU2IyNzFKRVRXYTdKOWIxY2xRWmt1cnVhODYv?=
 =?utf-8?B?RTVvMjlpUk9aMDdRNFBNR3ZjbThabGd2WGcveSttR3pWSzVGeitQU1c5Wis1?=
 =?utf-8?B?SWlmRlJvMEdTempMQjBqWm4vcjRMWElxM3FCWVUyTUNncy8wblZ1enV5dEJH?=
 =?utf-8?B?U0JFenNnRDdUaWt2WGtPVWNKSndtUnF3YzJkUTdpaS9ZemRhK2pFMUt1L1Q5?=
 =?utf-8?B?dWpWNVp1dlg2VmpCa2t3dlA5TVliQjRzWjRuTkt5S2JXcFQyVGVDYVJwOThj?=
 =?utf-8?B?eHI1ZXU0d0ZXRU44T0crNVZzR0JZVmZ4OElORlJZaTJrWVZKL3lHR21oWVMv?=
 =?utf-8?B?UnF0alpyMktFN2FRTDJLb1ZlTU1Za08rUWpxVGJsM0dOVWlmOWJWczRySC95?=
 =?utf-8?B?Sm1qZzkwZ0xRMWdCcCs3QXRIWkNuYVQzaXBYSW9CdjVGaG95TGtzbU1aTm5T?=
 =?utf-8?B?ZWdDVHc3TXFDVy9YTVVibFdjSzR5WU5XSWpDWmluZDQrU0NucjlRWVJxcWw5?=
 =?utf-8?B?VFZGaWRHUm9nSWJMVlp2NURQZWtteEJLWnMrUUw4cithY1NQQUpuZ21lb2c0?=
 =?utf-8?B?VjFpcjlWNzVaaE1CWnJOZTZOQkRkelc1SHhMOUxxczVWSkF4MTJQZ1BHNEN2?=
 =?utf-8?B?SkNlSnNEcnhySS8vVmZwaERHV0RGaVVyQXY1VThWcUFvbkZGRjAyK1phTzda?=
 =?utf-8?B?TEViOGlCRE1SOW5kZU9LTHllWGovQ1kwZXNGSkJOTEJ0MGhlWGZLWWIrd2gv?=
 =?utf-8?B?SVRNTFdNcmtjS2hSNVpyZ3luNzBVYWxiZ0xYZjBURUJsVjBNUWhZUWcvZVow?=
 =?utf-8?B?SG1DRm9xWDFFYTdhampGcGc0d09NOXJOLzhCSkZucWZsbCszdEN3anRIbUE0?=
 =?utf-8?B?S3RmalY5My9ScWdvWUhxdGNYN2N0NGNqdnVCVTdKdE5TQWxtbzZjK0F6c1cv?=
 =?utf-8?B?ZElQQzVqZmVxNU9mVzFXZGpqdjJnbDNqS2VNRFBHckNRd3hiUlo1d1VCSkNa?=
 =?utf-8?B?Nk5BT0doQU5VaUN6OS83Yko3OWRBVVdiYnA5YXkwTFNmTlJYaFc4c1NOYVdF?=
 =?utf-8?B?RDFtamFYc29CcXk3SFRTWWFMN0kzMFhqQXh5bDNZRXFhazZVZnJKL2c5cHhN?=
 =?utf-8?B?ZEZocFBQS2w1bkxJSkZvRS90bGRIT0MyVDhzMVFjRFdRWm1EZldnWjgrQy9p?=
 =?utf-8?Q?/sPeSKUpVyaU2aWxdQ2SFV0B+Mu5v+xMKjjY8EG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd98a07-25e5-4508-a81b-08d9356c63e8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:56:29.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSPzZj0Y790PH0l7R726H1AY0axFVkd04n381cUIaUokcMia1pCTgm6AeBRmQYxYyUHOjC/LY3E2Gek0vEK/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5606
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 22/06/2021 12:46, Dan Carpenter wrote:
> There are two bugs here:
> 1) devm_kzalloc() needs to be checked for allocation errors.
> 2) The loop was intended to be:
> 
>  Bad:	for (i = 0; i < board_type[i]; i++) {
> Good:	for (i = 0; i < len; i++) {
> 
> Neither of these bugs are likely to cause an issue in practice but
> they're worth fixing.  Also the code could be made simpler by using the
> devm_kstrdup() and strreplace() functions.
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reported-by: Hans deGoede <hdegoede@redhat.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for taking care of this.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v2: Basically a completely different patch.  :)
> v3: Add missing of_node_put() caught by Hans de Goede
> 
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..dee3d968e49b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -24,20 +24,18 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  	/* Set board-type to the first string of the machine compatible prop */
>  	root = of_find_node_by_path("/");
>  	if (root) {
> -		int i, len;
>  		char *board_type;
>  		const char *tmp;
>  
>  		of_property_read_string_index(root, "compatible", 0, &tmp);
>  
>  		/* get rid of '/' in the compatible string to be able to find the FW */
> -		len = strlen(tmp) + 1;
> -		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> -		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> -			if (board_type[i] == '/')
> -				board_type[i] = '-';
> +		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> +		if (!board_type) {
> +			of_node_put(root);
> +			return;
>  		}
> +		strreplace(board_type, '/', '-');
>  		settings->board_type = board_type;
>  
>  		of_node_put(root);
> 


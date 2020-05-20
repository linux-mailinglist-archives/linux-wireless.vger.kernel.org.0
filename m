Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892611DB43A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETMy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 08:54:59 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com ([40.107.93.102]:9824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbgETMy6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 08:54:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2j9SL/bV4qjuPkWDx2jRHkYfObLqQIF1hILCS9M70CJQuor6PA9a5TEj9VQZ7xWwmd0eHuUlzTaKFJgHXUgjBKZYQckUMe88Whz/57EWZHQUfGAqVmAQqXmPlp6EaDj+UvqO2E9+es3EtU7PPCFyuWjwGvRRQW1UIZZzrJTsQvPzabgieR4O9XdtAqmC3xB4mDnq/lDBWwp5FDggwlv+Tz9VkxgUhoti3cGZQfxoA1LkuoB0b4GfcVxZ5vTd2oxHJXXzpIHGnm4+Z+b5bdRprUqAWTnJzd7lMC7Wmi2hWbjwhoKvks3XKBr5Dmxoab00600Reens0T6/2wTFhq//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfJF81V688qL3WVpcluv27JlH+Gmg1ggSLKKmdjjPnI=;
 b=glNE7++5LrfdHPDjhv8eqrlFaj/93dPeYtkECQ6kIDlJ8QZlvlig4MHg/OY0vDONdiBQHboR+9qhrFhoDDRJ516QYMfz1aQsqlseDbdUpycZHIYwuf/xns6i0TstoxIWOVJlls0pY1M2u8WUH2o/4AgXlHAfUCxc74TW8adOk1gQ06LyyC8gdpH2R+VPoq/0fUzFHia6g14dhwaR7er7x9cAZrsuvzdp8WIOhzJgw7PvrylxFLprvnbm1i1oqL9/0w00v360wU1cVzdniKlXnt4hGBvlGxoG060st8QPxhMXtJ+qfERsmzOt+k/B+/Kx8lnU9j+K8P50MrgFP4erlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfJF81V688qL3WVpcluv27JlH+Gmg1ggSLKKmdjjPnI=;
 b=UJjG/lhxmSwnDNO1b3L7+IG4GsP/uGsN8fnqz2GgopiuYvR6n9fFiPvrY1GwCXMW8i/zHYAxP7cok9Z66QUAKfkaCBMKy/NkM5GGtyrIfUDhSGyGNI+5dyr+9fT/Qf9YzTn3qy5d9eAgTaLHg/l05N4aAR2LR5FUcbPiVQFOBWM=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5351.namprd06.prod.outlook.com (2603:10b6:a03:dd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 12:54:55 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 12:54:55 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 4/4] brcmfmac: increase dcmd maximum buffer size
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lo-Hsiang Lo <Double.Lo@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
 <20200519110951.88998-5-chi-hsien.lin@cypress.com>
 <8d74b434-abdb-cbfd-ae21-5c083011375b@broadcom.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <54c1f573-40f4-83ec-871e-2a811110ecfe@cypress.com>
Date:   Wed, 20 May 2020 20:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <8d74b434-abdb-cbfd-ae21-5c083011375b@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:e0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend Transport; Wed, 20 May 2020 12:54:53 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dac1f0ca-e8ac-4a25-1afa-08d7fcbcfe9a
X-MS-TrafficTypeDiagnostic: BYAPR06MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5351AC901B2B7597761E3B3ABBB60@BYAPR06MB5351.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBMcibMan0htrbcvihsNQ9o8Nj5O14O706wRG47zvXI/yqcIiydML72+u9bIJ9n76+00rDa5gvyZsX66fgWr9M83cs4u/pSfjKwThknWPYng9ZA+sT4lTOMJ4fVKQYSf163rMCG2gk9r3MjCYBV51O0Iz7V0UQ+fDb9gSiwjfsYZMKHP6nPwMlCEKbXp1Oua84h8Y7WMPTOYlqZGGrPIGjGMlwssX6ZtqtVmArGn+Us84x3nfPsAhgZEbFx6FLItpr75V6xnFxnI+ePLQ9blkrTqVl+aVFlTLZ2Om0fi9znxVYovhXTI4XimtGBG5wFuW0KxYe7IRmTZORVTW5BMBJetWLmCFXae0MnG57VluCQ9+HvwcS54q9XPIe6qBsf8Dq73EBeIxi8nOU6yJ7wxzVFlZPdo3VZZHUOvWJc/xgNahjXtlLrTx6jvBy2GdpY7vGxgyfbK1Ruotd3wpo94QkF1gCwNqch125yuehuaro6M3wxFunWDvsPj6k8C1iV+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(107886003)(16526019)(956004)(316002)(2616005)(52116002)(26005)(86362001)(53546011)(36756003)(16576012)(186003)(31686004)(110136005)(5660300002)(54906003)(8936002)(31696002)(4326008)(66556008)(66946007)(6486002)(2906002)(4744005)(66476007)(8676002)(3450700001)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 601nn689zQ57tnqnC8+0xu65La1k4NleKv4rGbOkObu5x4e1ytN48y3DX9j86ZrsJnzHSt6xPTzGlhbS21JLI/yWbk2URFXSjPBf5be9Q4Po50i96O8kHrEAxiPhqIbbpLUecdI1G5CCYdaYvwfnleye+4HvgpcfbLhXFUxrsgiGx5IRPGwN8F+NOC56+9BH5VZp9Ntm1ufrrTXnPPP8tfPUMdhrzee2EpWmJ8eA0G+oChZVQw+/d6DTWMPz2rb1+aSwJ3GGF7dFovDSlB8b8mB+Evj3eaQ/OItJwGRm7pLwBh+vdr80/loPkBGFXvNBQz8DGF0G1ABxoVs4upXRHSVazZAuEXrfsZaZ8h/SEQHBLKttctnSwKAziOfR7q8KMVlFydKsfBFp+KEeMxkSKZ2kLDlDQVAEvxe877nC4PpNixXjLX91mfFTCOiphw9AyNv4LHlBXcegSeRgQfKqwWk11X2AJnk/u73JbJ9DY9E=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac1f0ca-e8ac-4a25-1afa-08d7fcbcfe9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:54:55.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX7sjSqm6qd5G+jFCwP3NbcofjtlaEtPBQBOhe/9oMenCRfw2v8SZhwUv5y8/WnzK//BmTH10IkHH5Xhorn4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5351
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/19/2020 7:29, Arend Van Spriel wrote:
> 
> 
> On 5/19/2020 1:09 PM, Chi-Hsien Lin wrote:
>> From: Double Lo <double.lo@cypress.com>
>>
>> Increase dcmd maximum buffer size to match firmware configuration for
>> new chips.
> 
>   From the description I was expecting BRCMF_DCMD_MAXLEN to be increased
> but that is not the case. Please explain the need for the
> ROUND_UP_MARGIN. Is it always needed or just on some platforms?

Thanks for the feedback.

ROUND_UP_MARGIN is the biggest SDIO block size possible and is used to 
accomodate padding in brcmf_sdio_read_control(). This should be only 
related to SDIO block size.

The comment should be updated to "Add the padding round up value in the 
max control buffer size". Will update it in V2.

> 
> Regards,
> Arend
> 

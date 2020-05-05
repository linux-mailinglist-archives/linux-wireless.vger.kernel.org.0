Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6881C4E7F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 08:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgEEGvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 02:51:45 -0400
Received: from mail-co1nam11on2107.outbound.protection.outlook.com ([40.107.220.107]:36726
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEGvo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 02:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxdSJJK9l8mukZBI68Vi5lUZO+KfV29ACqeJAigryoyLDMGX0WBcN25gSrDPCfkXhjPHFOeSDHX7tZIPO6qUIR50ulFakqFalqx0osDAtnwSbOuv12kl1wLe+1mC6BQUH7HS/RW1QBxjou0nNPV4+g1MTo2tTEknNVSynh+Q/GFzFBf88WJMTlf6Y8WoPDTJDRdVqaLk8Wuhcv/Ikq5/nWTQyIEndbLMhWEtv1x9UmmW89T2ToYousK6k82DHICUyo64nKldWX3KvxHAY7FYqez774Y9ZN+NakfGfQNUTlSddt6m23LLae0w7vwXLe+X4xut/r8S2Aq4DLeKLQYO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xjNEMktwC67jOqKO0/JwERJW/cqN4VP/TUkCFfKbtI=;
 b=hbSgwtJLSyqJ1rloUtYmIntPoUqPbVuk9IVyw89sICOJi50boqCdXghFSn2FwH6bmPGLztNpFLj717ktdi4Ry0kxlkN6mq7y5Ujw96PjcQKP8rpeJRc4h04ndNBw5fQW/gpD91r3njARIeGXI68QdJmwJjckw5hJrmG9yx+0Ouq3Do+iXmL0XH4bs3xrWftnzARh5xjG0ZMot+u86jpyY/ofav7R2Y/jJAz8RZBQGWBkZta4gzMf7DkN45NTCKL+6ZbHwA7qW9Nz+LN306NuRx88ktt/WhYQXBrlMcbZ1jwHZjwEn449NuuV3IjRMSJKmuIKa2gpQIzpoaVXNudj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xjNEMktwC67jOqKO0/JwERJW/cqN4VP/TUkCFfKbtI=;
 b=Cwf404KDi08fhfjieCfP6IOm5t2faG2WU4VUzIo87+e8XG4uDdIdeQlLNiQUIksvoUbCDI0TqhJos+b/7mFx8vCnkllUmBOG8cfOZlIUMeKjY//kGgUuBr2SrtSPL/kQ2Fyl5g8U3Ze6IufN/txtf29hxoLOMsPHSyItZinv0qo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB6088.namprd06.prod.outlook.com (2603:10b6:a03:15b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 06:51:42 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 06:51:42 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/2] WMM change series
Date:   Tue,  5 May 2020 01:51:25 -0500
Message-Id: <1588661487-21884-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 5 May 2020 06:51:40 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9f99c56-9c8a-4bd5-c660-08d7f0c0c469
X-MS-TrafficTypeDiagnostic: BYAPR06MB6088:|BYAPR06MB6088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB60886263368BD3E74CA9C040BBA70@BYAPR06MB6088.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jF1pGPAjdN3CZO5dENpQFy1pBFBRuQQ9ACI4tS3ZQqfcOihBnYclCM7gk5bCFIsN2s/OHGGrmLTlcsc6n3upCX9uKAUGQetB3E7BFoZHNJ8ziB881cF2Apqhg1ZAUAT+niwchm02sZzIBxD0P7yD832V12m+xEmDUfYhLjPiGa0909mZOP6WROMaLW3lRzJGNxqnXIXbk+ioTnJTA8qEQ6bavsyukJBjsbn4w2+zwhXRSIBc1JKhucOLz8P0XQi0AZ5RKt6+sOSj4QkMA0Sb1gjDTwVY6BaQGTTX4bEIhqjG1LiLCtn9gJFHS36I2tiMBnInl1SBoZXyskWQIj2D26Iw2Bu0dGXSpsm54C/nuw6gsUh8ZW+7NPv14bllkhEP8ES4piaDkKHfXcFjFdETJRhyEAST6osINIF/5rDEmi1MGJ2MziPY6+bYeJPFWIyxkcfwEEIn9CbgB9dEj+7lKQ5pvpzzs8SduHtCxQWlUsn6le6uUX46pAQuw0QpFx6WN+oMPMMJPCaMKbMcJVy9pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(33430700001)(8936002)(8676002)(52116002)(36756003)(54906003)(26005)(7696005)(86362001)(498600001)(66946007)(66556008)(66476007)(6666004)(5660300002)(6916009)(4744005)(107886003)(4326008)(2906002)(186003)(2616005)(33440700001)(956004)(16526019)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4BFLCHBJQWThrsJgM1hZ/SkhShJ2dccvfZgMWqaFyKxhy6DlLZrDPEaVzi6EAYQjWfCLmC5PlaSLv8KwxX1jN6z36XlXjsKaUSglDT2oZ8SDK2gXo/ONFY0IH8m8Il7UKVeFCcfuxEr9whR5KXkmlBYqvlvNRj+nZwZlf2x/EZIatVRspl9N2hG6Y1lMrs1MF2DWqiSCsz6iXm5wWf4FNr9OAkzPyePZi0WTmJXRbF2mOFMiKxscE4Y1eXVXCfmonTds+PUDaiy1PN5IFzaRem238l7Pp6pLXjAj1/fKxLGMuTH7xGtla8cAetszvzMyod2uLnqHdFW+AgNx1EzwAhK++3ABMpfbncmshwY74o3hScFCJii0PGdQ1tdUk+X/elzC5TjAIcXSPBidw8EN2FWz9KAeGk2ohLtZ8WXv0RdwspGFAC9MmONXunfuNo8BfDLx7X5MOy7HWpuk/2exUjsOmes/BID/Z6boju4CYN8K34VL7SEuyvMDJ3jl7wAt2470i8s0DGXZ439t++eDsY5L+mk+WPEE/0/ZzQguJ8v6GY3Sw+JoVKKu2AGsQ7lx/3cfDpmnsNEUaXYEr1rCsSdsb/QSZrEPYV6zC/W3Oxm2IcBXY5oCaDcGkpegu7NeA67ocri+3V+nbewu5pqD0LwEeg73gW9KC3a2mrmZxTpvkRqwTnBSj0ZWBx9gCu5vuvayKM0TUrb3ZsbCUVewxnVs2ygHNyx2XFPAaMV6z/YOCVx+l4XUkzyDUF4kdVVcZMOAGCLiQPfiNkFRPDCWHbMVwHT3DUVY4uYR/M6BLgU=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f99c56-9c8a-4bd5-c660-08d7f0c0c469
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 06:51:42.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqPZ5kR5Tt3EnBU1b881c0eZAq6FfpWELcOODUN9eXv3oqDVioFfoqSQoMnFdGpAzL4JccHy0ENYI8ZvzcQz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6088
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes 802.11 cert WMM related failures.

Pramod Prakash (1):
  brcmfmac: fix 802.1d priority to ac mapping for pcie dongles

Saravanan Shanmugham (1):
  brcmfmac: map 802.1d priority to precedence level based on AP WMM
    params

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 152 +++++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |  24 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |   4 +
 .../broadcom/brcm80211/brcmfmac/flowring.c         |   4 +-
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |  26 +---
 .../broadcom/brcm80211/brcmfmac/fwsignal.h         |  23 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  17 +--
 7 files changed, 215 insertions(+), 35 deletions(-)

-- 
2.1.0


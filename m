Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29EB1F38D8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgFIK73 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:29 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgFIK71 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUGtobpfliC5ScA4QR4xx0pmG2j4hXb7rxBtcC7ALhMBih++hF03iZWp6pD/i5pggNZMe2STHucU4QvmvHm4zIeKYRUvsVQwlT+5HA81QnQzQpwrH7o/TceGwfs6r1kaNIPiU/2seoTnDpQ3J/qNIo+4bUCipakmQD+L9N2SyykBTIZjTV2MbZ+fENO6YVLTjbIqJxD+VoKzIl4YouSuyTmhTRIyrJhCS8+CEIkncG6L9i5eGvIo+JXfReXSk4C/YH9CcbR0DATXwtVw6iTF+6WY5kt+jsNinZkhy6dIsvmuR/IRWEV5iXr/oSMHGFtrjlh+lSx+kCi5/Yj+5EJzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyRih5vMOcasr1j5h8cpwYrdMBzmTWmg6jX1TF5G0x4=;
 b=H3b6XE4PEYJn5/qpRWzmSoBe8Up3Ir0iLoVw8Vgcyc2B5LOqqvaIfvttKARBvAwFjMcKZ1GOZAcK1SNXVQ4LLOGwKYibNqN5Y5qF4GJDvxNZYF0nG0ppVREiNSoe2BKK6I+xumCWHg1ooc1IRSWR3KSRylK+DzKCjoBvHPJzrFwXUzewMapH0HQK9PnDyxK6k6KI4G0rK8YLGtZvPhrS0ybhtCpS8je8f9SNw9rn8m0W2WB8uFo6ts3JF/v5tfRzYqoNMHbJ3TZLXHvxkqbtuS0M2sV/6420Rhej/1yjMp/bI15i1/mAz137WkvqICUw4u4mb3SqFVMhdl8V2yXdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyRih5vMOcasr1j5h8cpwYrdMBzmTWmg6jX1TF5G0x4=;
 b=nOBiE6T/RHpXlL2CFbv9/OG+eE20jwRkG3vH2wQQqy89ZOWKmMMXamykrDm/pGyspBsnnmbToRvHrIxBvQJGUN5ot/uL4RLeMFMLYhJRSHAFZNcmOdWbLvCBlWmkl7ndb++Co7678RWP/BPIX7DU921P1YWQrYRWEe4H2yRy85E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:23 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:23 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/6] brcmfmac: flow control and p2p fix series
Date:   Tue,  9 Jun 2020 05:59:07 -0500
Message-Id: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:21 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2a38d15-2877-4d10-0ed5-08d80c642aa8
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5064B0F1AB2923F2C855FEEABB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T32a6s7aPARvYP72YOGqxOg2iwPYuqu1bee8jvDadGkG5CnMEQHnE4YlzZ9p0kdnzkNEvvkbYq8C2MiWJs68GuTGz3O65Trr3oRKNymiNXLsIkByKs3acs0fJ/VdFl939a2u13wjTQ/RLQCCL6d8kQJHDTaMpCXU2WsoB6n9CM23xLz2ODiOp9GckzIOIVlegqoAFQ3PBlo3tc7NkK3r73/VUh8Ts8Z8Ro4ffdEYEw3Y12UIDqKXOp0RzT46F9xWw8QhmE0XL0d3ls02Clowz8+hRchxvxFJRVpz2UujfLPNP+krqmXfZ6slcelYGPb3mSBw1LJj1CEtNn+zfxIiQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(4744005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: E5bQzT7tJjvzDW5dfvDVitCD3baP9pfDqjvfxzqUmHrAIOfX+GygpKzNjLx1ra9GqCA4CCZrZvGzBM/jNvCyCixQreQA6eHoqzHfi7rlIZHSCw6aiJr55/JRhQ1P+iq0M5CFxU7qlDpCQTc9Z38RcSR1uO4OOmREX2yG/zSvC3FMqakd0Pcs8EMJfa/XOwXL+VeIf2yrvYxUmPm/10jVLdIaEVBGDGPXdRcAn+nM0MWZwPOSpPjaMTAuooamn4gWOcGwkOc5N92+dCwreaWBfsBqM1/RecSVGRkEV5D4xfMImee/0MEJNV7l9Dxx7C05yNcrk/GpscaoRVIB3uiScrfkvSpjJfP4Cbfx70YXCMgDxEajfmtPz77UvS4RvjmhvAI1HzzlYtkYNbC5RIQ2npUWCrFW/uwJWGRCt26kQMPBw2MqR/Cbr30dIwPKGHdObxgcDL7QlrmmVKIvfgjq27kig/aQlsbZX7KoNa7riRU2EKRJyH3tCIfNWh589kMg
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a38d15-2877-4d10-0ed5-08d80c642aa8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:23.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCiwhHvSlqDR/RbVgjxQc1wrJlCWv+g5hsaGh+7zZvuHDn2Kq7mrKD/do2Nznk6tRDYvtI5VZpdAX7jyegDh/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix WFA certification failures due to flow control credit issues.
Also fix an issue with a varialbe (dwell time) that is not properly 
initialized.


Amar Shankar (1):
  brcmfmac: reserve 2 credits for host tx control path

Chung-Hsien Hsu (1):
  brcmfmac: update tx status flags to sync with firmware

Double Lo (1):
  brcmfmac: fix throughput zero stalls on PM 1 mode due to credit map

Jia-Shyr Chuang (1):
  brcmfmac: increase message buffer size for control packets

Joseph Chuang (1):
  brcmfmac: initialize the requested dwell time

Raveendran Somu (1):
  brcmfmac: allow credit borrowing for all access categories

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 68 +++++++++++++------
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  5 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 15 +++-
 5 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.25.0


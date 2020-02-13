Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9876515BAF9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgBMIpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:18 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbgBMIpS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/gkg4Y/+mZ9WqxmVm9oKa2nVlp3t6NO0DdeByfy58GBcah4sQlgtypzTVFy0cYMtbt2w9memApJesQcVm+4mx5Ig8KSh0PoO7k7sxHa7dvtxeWokOk6SycyKRpCFguMXDwB5cWt+DiGLl6dnG4tJd7ayxVGCbx1UR5Xj+QdPpp+Yqb7BMnATi+PpRhuomqpj+EHhgc5KKIlB5StLkgwgOR8S24TgTLfPzy9WpkGme1tjgEH8Qws61Ql/c+PH/9T+ZGUEKvNPNVLoaC671nUvYhrJGArW8Dy71lEbc42Qn3yL3IOoM4y2+alDyk+JUG7BWWCwG8Zrc/EQkyTNndxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVUFsuMx9Jb+PSE5hixRxB+b6ztt9C1M4XixdIVvdUU=;
 b=hVCo2TrmnalsO7x9YWKA70lUNW/VWkcILFVt/88zBh2U8ncGQP4gMN7w8RRF9si5ZZ+01dbKnsNjamr5OQYGBYDBJ3tYDdEKn5kBkex1UsLvlFHolnNcBR7iW8Ja+FC67RNyZEJCaHuiKq8dXSOA95JJJTnouTPzl/lpsLoWSxZLMJeazwmVgpbaS4EXr8yU/9wEB2XoGOIE/sVHEv0+mSYKeHTQIWQqakY1Evp03JRKR9kwXiy6Z9E9qEnLcXd3HlnXBIXfGpJG8IvDkrrdc7vzriQ8wAB2zpkGBkh+x/KCRQxLpJBBZQixEIcI1bS7Rnrru8TTjrzTvZ9CJY5IjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVUFsuMx9Jb+PSE5hixRxB+b6ztt9C1M4XixdIVvdUU=;
 b=IUFiLd0yWGY0tSB3NoYll49BvMLKhAWui6HZKM1suJ9TeFe3+0gdRJ66ZLeEu1hJFPItREWFh4FyH1C4FESmulHZMEblj6O1e0zsFYIUBAmRPCzhRLnE1mk33I2+aynThJ8p+odQzOY96Ig3StoLTITYdwBCO7xTZ0jPn+2CzZE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:15 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:15 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/6] brcmfmac: USB change series
Date:   Thu, 13 Feb 2020 02:44:30 -0600
Message-Id: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:14 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd0d5f93-9bf8-4d62-0b21-08d7b0610b66
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB56238E9C85A91B824EEC561FBB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(4744005)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sib4A4hcivAYszWN5QS3xbyv1e8pfhKWaw/XnYEyIA0Y7zgQSGwG1/2Fwb5xdLktGpUS18gqJPTJcrd07Wwx1tt/r1ofQ294bBHTgow8f+PsnM9eoIRlgL3n4Xh4PcsAnG3NQztdr9uVs3eX33sdvCzF/014GxRCuV3cX7bCV8mjrlmron8r/7YLq+uAFN7w4X0p24IRjtU6eRe5Iw9KJ8oTG4Mvk43DOqe9bViCMjFfqMMwrkq0NVpbuDpwlpoBEq+AOxc+7hwTJzUkzifxvaVobWRwpesO4S58GyLwN7ROR3ICPDqdhRFrrbHghR6xIROCM8uajSPgysTd/OEVUu6Aw/vbzR/jOHOZZwrifRBtssRmX3ZvWhn5VlazvDL6oeAkGoYhXQI7aWGoSF1z2Fjk+7ipyksNB6AehLlb2g/aoDNdfWSg31fwx60A/PQf
X-MS-Exchange-AntiSpam-MessageData: 19e1EeKxOfZWMXvtrvlIsD42ZaSSB56sBBIUPPc5WnHtKCxPLQ42ey4OzgyefTDhKANLUh7mJP5Ts4qUwutrX13dDxdBngUazs3dmGzzDxpqX87Pi63jgTR+6vnVVtjCedLIOj13Uzm+ra4uckocuw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0d5f93-9bf8-4d62-0b21-08d7b0610b66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:15.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkFJ6FuyrQVr6IPwh07GdbTEY0vu6fglwCbYfCYScFpmw1tYBC3QxpEmwdDU2P8mobhInisSV75gzc5fPX9UKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

USB runtime PM and console print support added, alone with several of bug fixes for usb devices.

Madhan Mohan R (1):
  brcmfmac: increase max hanger slots from 1K to 3K in fws layer

Raveendran Somu (4):
  brcmfmac: Fix driver crash on USB control transfer timeout
  brcmfmac: Fix double freeing in the fmac usb data path
  brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
  brcmfmac: To support printing USB console messages

Wright Feng (1):
  brcmfmac: add USB autosuspend feature support

 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   8 ++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.c   |  82 ++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.h   |  24 ++++
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |   5 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 141 +++++++++++++--------
 7 files changed, 207 insertions(+), 56 deletions(-)

-- 
2.1.0


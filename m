Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39A27A710
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1FuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 01:50:13 -0400
Received: from mail-dm6nam10on2116.outbound.protection.outlook.com ([40.107.93.116]:54849
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgI1FuN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 01:50:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAbaie7/oZZPYDWrsOBzatopY8yLOzS4S/GQvhVIzdDA52cSGgT+jGV2MxD0+HJbcnVrRwnjpDpoZZkIRi79tkbyELPK3Bg4AqQJXTlS5tnLdVqKY2k/EZD1/CtF1HD0eJU/CyHWOZaUJcKuVDlseO+05cIoGBMYsZgDOTqX3SoF/7DvQq5uw7TAKNtXXWYvNfmLPUJ4MvOMki5UUTRqab+nEmBFn6F3svgEXFDhTlhIo9wk8WNLK2kR8T0sJJK/31abNGhJ5qGZ0RWrO9bXtxoghM2kyeBA29NjGENN5Oq/5fX2aiqrgQ91GCvz9kIwtMo7+YlWRLXJqIiEELxaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oftZLVk956h9pyrmcCGWeIBNMKOwy7mBJIQxdFblOvs=;
 b=iVoMMTqAYTA5rfG/VrKjUADinnyPUkFvxaf8k1rl3RCPM8GdKnb0DYVlatm1EwPQ0pBO0K5jV93aMc7e+L2zvE9zksNgvyW8J5kxByuxR4LCYgKVnm6E9kd+zNjAoyMpXFNFb2FLgdtmgcsrJsianTbk3xLqsmvoy32Z1gIsjLEmannOI7UfjwVrAF1OwfTl6DcZcgZn2W80kNNhZlkwKRl9gFsItL3Mrwv+0dKbCsXb/y0XXZjGJnFql1gf494JsUQ1n82Kb68K803JiOFn1LITGRaIhw/RJ+a9p17A6oydkAnEHNvVjYFo1+i6c/jyM/A0vwsGQPwhe+J10smqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oftZLVk956h9pyrmcCGWeIBNMKOwy7mBJIQxdFblOvs=;
 b=WE5HXg7JQD7GDbLZrXYtrG3XQqhQ0vWx7H35Efrp8I0aXbhosif+sWYb2fc5Ec0axOgfUZQtZDGAUD6HHcyfvSGb/txEfYq83KvJaGHfp7H8MDGuiK8orSgazgnabQq6G1WsvsMFsYE0aT/IQw/ygtV2XKuHNghYw6BErumUqoE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB4097.namprd06.prod.outlook.com (2603:10b6:406:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 05:50:10 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 05:50:10 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 0/2] brcmfmac: Fix warning messages when meeting failed cases
Date:   Mon, 28 Sep 2020 00:49:20 -0500
Message-Id: <20200928054922.44580-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 05:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8db3cbfb-cb22-4c2b-fe45-08d863725c82
X-MS-TrafficTypeDiagnostic: BN7PR06MB4097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB4097FA73CA1602A0C5918B27FB350@BN7PR06MB4097.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:80;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRkZHcpAaVuJhPDXN4n7o5Z05QkGbUQU4m25xs4zMKfkMtghivSiZ0T8nQCnM42hlRO9C5S0hNKgmMSW8qnwodpUIdw9iAKWcHWSPOjTNrM1SImWntT763tkLKu4CypOWRP664gOiecMVhB6GhzRc68NFlKarN1PPfjdxAWxe5qcyKmNM1I2GnbhZ+YTkVFv+JE6wbEIYs1LHtYul1BhEK4nwiHlY6hc1pJgVFWYZIdrxaKfOmZfVBq5txZ6vGQDF4Y/NAVqcaUQuOlnGylDV8m/dH7UiRKmOtBkPNy8u5NpzLn9l1l89sJVdHlDBh8gt2M1BXb6YdhAuU2cpckJPl03qn3gMexVvplDQgYs0OBRDL+MvRabyFiEoneczrZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(7696005)(316002)(36756003)(4326008)(186003)(6486002)(16526019)(6916009)(44832011)(4744005)(83380400001)(2616005)(956004)(66476007)(66556008)(66946007)(54906003)(5660300002)(15650500001)(8676002)(52116002)(107886003)(478600001)(86362001)(26005)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5QuV5efJ1kP+J1in5CQDoNjHmSZ9shHkxMb0UhzSiCewKPwG/RS0xry7IrCMBcJ5xu9UW9XhudPTOiLymn4/l1jKMHPOQSKZo4LeYk3UElpyOiQ+F6EVW/MIZyG0VNwiMMnBzhGy+SvPVUTzlct1o9cDPDeIZecIF8UzSjO+2gSBwIaY+ye5mEN6OVxckCU7zqkIkR5kZmLLr956r2R4EG7bvhetSTaPcnO9Qq3IRHdyopiPulQP3He6KW+vzBKLcOBN48vig9oZHjUVF8sBK9aXMjuWpf5VlSnKkhVrUDMfKoGvfTj5EgIpfct1SKm7xQEC0MiCHQkaOMOuy/lZ6rqnnbH57XBJ2psz5tgmJ6RKx43XWQjBdC+Xoqxt7yXl6+1FhmrHc0XdeLwmPmLaPdOPWh0BTtugTGNBuU5R741e0ydFKJGKCzTFyJnSDROOPAyOStUD15YIyb/zppLPdIYO/Uzk6UMqIL6y0WbVUox0bsBz0s9XeIpXgq6c/TWwTf9eCbM3t7tAxqKi+aukJaP5VUIuSwf8YlXxWNd+nR+QhSag4dTs+5aoRsK47uQhh9sOnrhRU3ou6CfuIhKvcnefX9SrZtyW48JroyH3XNh7fkB2XYYsK06aGM9dGUdRZRcGzyVFCUZ1h8Y2AaQD0w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db3cbfb-cb22-4c2b-fe45-08d863725c82
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 05:50:10.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd2m0ieB3rsLVL2YgTtBIb79R5MzCuiXdtj2kkrO0GQPJl0F3AMXbg8z2oMHyqLZW4ChzaO+ktGm1TbLH6t6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4097
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series fix warning messages in two of failed cases

Wright Feng (2):
  brcmfmac: Fix warning when hitting FW crash with flow control feature
  brcmfmac: Fix warning message after dongle setup failed

 .../net/wireless/broadcom/brcm80211/brcmfmac/core.c   | 11 +++++------
 .../net/wireless/broadcom/brcm80211/brcmfmac/fweh.c   | 10 ++++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.25.0


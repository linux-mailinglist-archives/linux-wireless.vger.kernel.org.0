Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6F1B97EB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgD0HAd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:33 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:31151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgD0HAc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilxmQqIwkdKTaCwmzj6UWJCPJQbw49VMnUHKszqaeqH3VvBeL6VRCxOCh4IiYqHTUYHGJvQN72fT9HYPRX6JM8PuIi+/yV1myTm7EW185SrzjFw4Eq45haREHYXXNG+ivlIcqjFwnoukitgEdqxOs2uvWPpa+wczpoAmx4iIxpHcVuBRWiJJOpPnr5P0SleXsWk0YWAjvADHVJZvuHhee5AoVeofbsB9SUUpCFB/bvrHSeAWWu2M4sarUEqMmzzdqK+RTxO04QsCfgfSIdRe/dpCaq1NfKrInsrrHXQidsqsnb9mU4XHvABjczX+8XbpINIzWokv9d2JnZ0NXzHd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpuAdz3njl+cB+PGJxAT6Otc8k1KkD9OfqWQuqE3a7I=;
 b=kyzHT0DJqugUbmeWg4X7XxzuuI9E6pVfXIPYJErJjjHNk80j2Ou/SE1vnzvz8OFs633Bq+hpjwlYplQBe/OLW3rx0zG0HjaMBeRGMRg4VSvhin9ihT+cJFJHYBXiB6BDixSKFdW73ppID9VbTe4HTKhtR8BHRYqa8wE/ZoQ9+2T0ycQtdDGVnhKG1fCIhYR997PyULha/AmppjTwNZ2+OBx0dMjXVnA8GsW7ondqSQhONmPWCyn0r7jPzsFz2puP8cuqRwldYXr7XKS19eSYJoyFyVYrk59OHAEqHEEfnDd5Qt9fvVjVpxv6wv9qE7PD5aWAgwDvO/1230JIISx3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpuAdz3njl+cB+PGJxAT6Otc8k1KkD9OfqWQuqE3a7I=;
 b=RJY7F0AwVd8dyQD3z9FHBQdTBHPIiAb36b2x5zr2JQ712YrJKIHl+JmNA6YX6iOEfxYtigtoyBDRj8n8JNnSHpozrCbR+XZ5xFscC67cFIHy9eV/t5f1AbkssN91ftVGihf3w8sHy5mJAhZV7rzoZ8GxLh6ef7sboHcqUgWU2uA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4551.namprd06.prod.outlook.com (2603:10b6:a03:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:28 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:28 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 5/5] brcmfmac: add vendor ie for association responses
Date:   Mon, 27 Apr 2020 02:00:03 -0500
Message-Id: <1587970803-77700-6-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:26 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1da6f307-2d71-48d8-2c72-08d7ea78aa82
X-MS-TrafficTypeDiagnostic: BYAPR06MB4551:|BYAPR06MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4551648E18DC083A3402AC6EBBAF0@BYAPR06MB4551.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(26005)(8936002)(81156014)(8676002)(52116002)(7696005)(86362001)(956004)(5660300002)(16526019)(6916009)(186003)(36756003)(478600001)(6666004)(2616005)(66556008)(54906003)(316002)(4326008)(6486002)(107886003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9I8dGvdq6LHEi4NLmEhPjEr26T/G6Nr7n6faHAKYR7DHsPkWziTFznlk7L44SgmMYYYA/KWMh2QirGxAbVEmqXmR0kb7xkswFZk3ZGvGLBtEhfVKZo5Ka8ohdtnPfSvu3+260MkDHe9jZw/tX8NuXxEJkiC44qaVzMGJB40s+t5kfFzGVoT9YkSpKfwPfOGvOh9KhaUc9yr68cGFLIq1enPsl6gssfusCzbL10wiNALzhdZYdCBATc/bpYlhlL0ca1SJ8atOAcnX7rSmTVVr694h3KoCr8QHo3M/Nq9X59HramK24icqgtV0JL3Qa9I4ZD5MzNz8qZV8OqtDr8G99o7su2KKlUhrMXSKvb8J3zmKFKzF1rgpnKn6C2XnIW22U01Iz6d2Kkw/yPWOyK/9lFKyvv3RiMXPymfLXSyDgCs1Cc2VkwJ2buAvOsencIey
X-MS-Exchange-AntiSpam-MessageData: QGsMbKnGoifIqQCS3kW+kPm8GFmGmhpRf6B28FbRh22msfrUtTcGDLFuS+HJMYXCwBdLZbyfnam+Afxl7KlfUl7RIbcrLjw3/s+6zrKCfc+coTEQmj+BCYqB1hTiOyz/9v43+j/aF6vGolT9/F+IiT+RnMWqACPl/eXNnZQuZwT8YfI9btNnSCTgZ2TwjGzthZyEywzY+WAWC2j0ceXmJIQsW7fAQZzoc4bFaOv1a5XECC2KcUT5ZZogN/e7LsgrC+ME34cITfccMgACDpGvFQfcATfyYtpzDvugZp0Ne7aRSZjkFBMUmlfMdCoh0gL0afkAa08tZU5r98bG5lbF8qEblymNRvk8jXIa7MoDXpfN849O+/Ef5a80c3+3EaEQpSkLuaVBQJqjr9z+Bvc8HMQSOiWPRHYWcIMfihZGSiRBu6dFSArBCzG/EolHlCwg6VhtfdO7DKSYk6utEhrth8GasesI4rCuoFEw4/I74MeBVRLOHBG6EG/67LE4A2Z7FKHaWyKZDtZg1LkFzQdF8wEPaFLMV9HzKqlBHsHKab4w0ENIkD3upnWblUywHVjvgfD9NxiJlx0R53pm9gYdmw3EqeH3P5aLhhoTV1n4eqMPD6x02b/8BNUFTzosdCsb/++Sb7BQxMlQotC9LcSIdyKgf28Yry5O/gexVVILCWQbxIVhdYOPwyymnB1CyQPbYBaD6Piw0Mv+n8JJpZXMQBQ3X9SLQMtCe+Prw7aj4X4p+DIxnHFGGZ+88eqaZe6d8t4QxPrmtDVadY5b84/UWJAJw4Z/OQ0CYtRmdB1QHSQ=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6f307-2d71-48d8-2c72-08d7ea78aa82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:27.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p6pfsSgxukLFqZL92DZJQwdKQdNpa+beW0qKdR64QbwZyZDgoDtR6AWi614PoS+PIoIb3p5zibAgszkRg9B8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryohei Kondo <ryohei.kondo@cypress.com>

Miracast Certification clause 6.1.2 may fail if there is no WFD IE in
p2p assoc response. This change allows WFD IE to be added to p2p assoc
response.

Related WFA certification:
6.1.2 P-SnUT operating as a Group Owner accepts a WFD Session with a
Reference Source

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Ryohei Kondo <ryohei.kondo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 14 ++++++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h    |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e54f6fa6dc8f..4bd69d85fab9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4449,6 +4449,11 @@ s32 brcmf_vif_set_mgmt_ie(struct brcmf_cfg80211_vif *vif, s32 pktflag,
 		mgmt_ie_len = &saved_ie->assoc_req_ie_len;
 		mgmt_ie_buf_len = sizeof(saved_ie->assoc_req_ie);
 		break;
+	case BRCMF_VNDR_IE_ASSOCRSP_FLAG:
+		mgmt_ie_buf = saved_ie->assoc_res_ie;
+		mgmt_ie_len = &saved_ie->assoc_res_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->assoc_res_ie);
+		break;
 	default:
 		err = -EPERM;
 		bphy_err(drvr, "not suitable type\n");
@@ -4595,6 +4600,15 @@ brcmf_config_ap_mgmt_ie(struct brcmf_cfg80211_vif *vif,
 	else
 		brcmf_dbg(TRACE, "Applied Vndr IEs for Probe Resp\n");
 
+	/* Set Assoc Response IEs to FW */
+	err = brcmf_vif_set_mgmt_ie(vif, BRCMF_VNDR_IE_ASSOCRSP_FLAG,
+				    beacon->assocresp_ies,
+				    beacon->assocresp_ies_len);
+	if (err)
+		brcmf_err("Set Assoc Resp IE Failed\n");
+	else
+		brcmf_dbg(TRACE, "Applied Vndr IEs for Assoc Resp\n");
+
 	return err;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 6ce48f6275a4..3ca8c07d6370 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -153,19 +153,23 @@ enum brcmf_vif_status {
  * @probe_req_ie: IE info for probe request.
  * @probe_res_ie: IE info for probe response.
  * @beacon_ie: IE info for beacon frame.
+ * @assoc_res_ie: IE info for association response frame.
  * @probe_req_ie_len: IE info length for probe request.
  * @probe_res_ie_len: IE info length for probe response.
  * @beacon_ie_len: IE info length for beacon frame.
+ * @assoc_res_ie_len: IE info length for association response frame.
  */
 struct vif_saved_ie {
 	u8  probe_req_ie[IE_MAX_LEN];
 	u8  probe_res_ie[IE_MAX_LEN];
 	u8  beacon_ie[IE_MAX_LEN];
 	u8  assoc_req_ie[IE_MAX_LEN];
+	u8  assoc_res_ie[IE_MAX_LEN];
 	u32 probe_req_ie_len;
 	u32 probe_res_ie_len;
 	u32 beacon_ie_len;
 	u32 assoc_req_ie_len;
+	u32 assoc_res_ie_len;
 };
 
 /**
-- 
2.1.0


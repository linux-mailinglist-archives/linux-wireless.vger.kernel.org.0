Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40FA33D706
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhCPPRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 11:17:46 -0400
Received: from mail-eopbgr10090.outbound.protection.outlook.com ([40.107.1.90]:52703
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232348AbhCPPPv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 11:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHlcp7576HHAbBeBBPbqexHn6vrLCXN8+J/00ORKOkC+GNiuwtI88dO3K87hO6IUVMYEnVyoaV3XNAwCEFclZpuXM3OkTxdpT9buRci1vuaFMKIz7ubJI917AXqaTtdFdeoosR6Is1bjpPVyW5gRaDePi8ytCmH2eJSCoLJCxS+vwVDySwMk0i96G1rG0R2Bqow1CL4TY5njVzXGosub34uaTuqURrrDFXoijHmT5FI/GJOB5ENmF8Q8Ec7Tkd80jeZ54JJTdp0k2mIip9HG9F1HgevQH/JxpyPMlkcpiyY6ylFtw82EqZvCxr/N2p4G/cAShc01bUfFvpmcCGAYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUyrLul3QBx8CecSlCaGCURkz3QAUTLfyUObwDA9RM8=;
 b=Sy/IqLF517I9/gGNgYOyGKUKuYh87D2IW4/Kwx6KHhp0RRGmg6P79b2RmyKkJSQks7NvGRihmdl3AHPw5U+/ByLj09n31Tt66ZpRbF1aqnYchxNcHYGXnAeQsH067JVcY6bWR4m4X5XpsEMTRmOSmQ2fbnJuefPxjGLrlmMqAkwXwu1rRqjd8v0J43Z1k2HveJWizvCvT9EEw6r2fOSeu4eVv+LXytmaLXUz4XmqtvO/HK0Vb9Ss3DgFu90ykq08AT5BnYAUuz+6+O1Pvj1eqnCcsnlsnUsjF0nZlY2dHjJuBxPzYrpqTm53+s0Q27YeK6jMlG751lpua89a1Cc2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUyrLul3QBx8CecSlCaGCURkz3QAUTLfyUObwDA9RM8=;
 b=2mFU0+fyScoPhqOy+iEXuiVM6c+xmF2Z9tjHRSvmR9u9ay2eliQp2J5S48sHfLUOXAGZxKOjc6mLrOaRVmgMuiWTV5gUMbXtMeblCeV8xgrP9hFSSlT6zx1vbJpfKUpIDhBEI/uxxyjBYNq0AkdAMUFBl4WDsz56nNkn29G1iG4=
Received: from PR3PR01MB6714.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:65::7) by PR3PR01MB6796.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:62::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 15:15:48 +0000
Received: from PR3PR01MB6714.eurprd01.prod.exchangelabs.com
 ([fe80::fcf4:8ba8:3de:9f0a]) by PR3PR01MB6714.eurprd01.prod.exchangelabs.com
 ([fe80::fcf4:8ba8:3de:9f0a%9]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:15:48 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: WMM doesn't work for VLAN frame
Thread-Topic: WMM doesn't work for VLAN frame
Thread-Index: AdcadHCybNZXp2khSi6M+ePRwqq6bw==
Date:   Tue, 16 Mar 2021 15:15:48 +0000
Message-ID: <PR3PR01MB67144B33C65712847FFB558D906B9@PR3PR01MB6714.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=acksys.fr;
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc3cf4bc-dcf5-49bb-866f-08d8e88e6136
x-ms-traffictypediagnostic: PR3PR01MB6796:
x-microsoft-antispam-prvs: <PR3PR01MB6796C728B06BE789B2566383906B9@PR3PR01MB6796.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvqFQ+dvheJcF5O+CXYsyJt/o6i83WjMAq7+6IpA/H/lu1zfDA4CEC/8opwUYve4B1hzgnUE0bHi1X4UNbFXZE97axoeR30Si+JocLwU1q4rJbXEERMucJVlDkaYCIp65MNVh377RqzmmOG+/rN0KBndvKsziA2yNl/kfCXEfO47Qdl9QTJjGjbPuo7ITatCjSPK0RbiVaAWr/F5ot2YBW8woEY9wWM+SJgYK2ySMZ+lQZCVtYCUbORYBL+gv7Tn93eRHWMhhNZtbG40BkHCF5PdoodhMLUh/POEHixQek+BSehLcGqo+oviKkd2TABM+HcuNZYXbgHHnlXLfrTqoB1wxyyOR8OYalJytnBpunQQQI64IEQYwD0dzmBbZsZHGYygl8sfXbSxc5W4EX9NvtiugdFfcxN1g60katg4PBm9VzkntHkcQ8GDyDKaDnjxBnO6ifsGp4w5PDb4Ty0TChT/74M/5iqln/ebY9yk8JM8lLrEO1MN0FO1pJlu/BbTZ4dXdEVZs7rb1hB6s/McLyXj+NhdNrpUPApf8BQfZckd5mOSrpj1C+4zTzcxVoBK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR01MB6714.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(376002)(42606007)(136003)(366004)(66446008)(186003)(71200400001)(33656002)(2906002)(8676002)(86362001)(26005)(76116006)(66946007)(55016002)(66556008)(66476007)(8936002)(83380400001)(6916009)(6506007)(52536014)(316002)(7696005)(9686003)(478600001)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EomWZ5pDqytJbkGRR5raMVLMAiZCojETmaCauq7gNITsG32qxZsfqrBL60kv?=
 =?us-ascii?Q?Y4NOLkY3wBGNFj5hcb4aXiLk4/kwjZBanoaaLxNJ8w0zRdaBkwsVNxWJm6o5?=
 =?us-ascii?Q?jhRlVdIGngPBMuX1jYKUEEhXBRKDaCeN51dqMyAtGhYdPPQhSugvach8rS8x?=
 =?us-ascii?Q?p6rLcf+6PdTPR2Qjyo8ryCS9FfXlHf5npfRaA7wBp+fAy2wkFOk5iKtu1L78?=
 =?us-ascii?Q?MiI30nnJHpUfJbeQsZMSQESU3iBOUO4DDa1RT7ziLVoL6ExzlO2hz/Bu81XS?=
 =?us-ascii?Q?7v1rLc25ksSJeCFW9FmNYSVQ/wE1XW8AYFT0yCQCF/8COUy7vQywiBLaTo6U?=
 =?us-ascii?Q?WVibLbbn+1NdtDzVRSb2GftYlt4s5sx/BpLTsmdw0s0Zdn/YuQ6M5nxFA62Q?=
 =?us-ascii?Q?paYcxP4zOpfIWNwm7FYylfDUbOrXEZxqnAMZVaFNK+GnL6PWbVcxAPa8Ku1m?=
 =?us-ascii?Q?vNKJP9cmZZg9giMAWQVzSDUDqPHuC3NtNmTXgDAt4gz5isGPWBw+dkZ37XWy?=
 =?us-ascii?Q?3nS5qERu2NjdtA7jflraJKzHq8Fvhmlw4IRzFpg9ZatD7s9StA06LYohgyBq?=
 =?us-ascii?Q?5rkX9hJIpZx00i6r/vcCmMH/66V6CLHFzudICsXbOTWOp3M6hHKdORR3XMTg?=
 =?us-ascii?Q?6NkrTvt89y0t+7JNlrfrv7Z8shapoOj1cu6qEZ31w+vUFk0Bs3pr1IMcBinm?=
 =?us-ascii?Q?6Dqhd+v6QMH2jBlkDYTSp0v/xJH1bySrf61f8Cqi4cJtxW1xVJvTNBnePVyU?=
 =?us-ascii?Q?mMdUslblzg0T5yfZoxG73dNvxi7c0PgW9ZxQyI7cRI55OC2FSccOSaGYYR4y?=
 =?us-ascii?Q?sbmJltyDWWgYD9e1Fz1a/OlyomSqYbST2hSTX1IK7GE6GPYgl/rlw5LXNWJ6?=
 =?us-ascii?Q?kazs4dfyzzXJQRC/hUXlY8vFPMkT4e3ggq/RqaxqpTt3TBvH+W8Rgp7q32aQ?=
 =?us-ascii?Q?lfDSXnsasDH03KWupkW1Uf6dakXc6t2yOEfLs0D55W0DY5Ig/mfViiv/rVAv?=
 =?us-ascii?Q?7gJcrrOsoNfUncDF4GRqbsFhMGbvI3NpbsfrrIzbm2xjKXR70Z8V56rF4wmn?=
 =?us-ascii?Q?g7K7teLqISSP1ijk/kgZhkopSp33+mfoC7gaoaIaFUOlhuKGaCzKv6XiahCd?=
 =?us-ascii?Q?h07Tm2eX5s76ySsuAIGZzd5rgtVLwhzrlbIjNReCAcB+mEPtZC7+tYUe/Qry?=
 =?us-ascii?Q?xFgE49VteAsfd7623woHpiv4anyFGqU1tZQOrxemRm3dPj6nwFQtnm0HUqyw?=
 =?us-ascii?Q?i2oPDBzxOjDPkpPT4YTWDz2d7SIZBtOY/E1Yq8fCjyZheJgdtYhVzPog67Sj?=
 =?us-ascii?Q?VA5Nx2sxe9PcfnW4Ev5gBpiU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR01MB6714.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3cf4bc-dcf5-49bb-866f-08d8e88e6136
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:15:48.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFPYNlQnt5PcU9cCZWd+nX5MZhgtX+6n+/hazkTCoFjiEfTCyCc1cwHRDbLzasM4fXdVkAhvuhl5nD0C+SfUq4JWkNLQLuHQDUXtchw6lcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR01MB6796
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

	Hi all,

	I have an issue with vlan frames and WMM management.
	I use an AP and a STA. The AP have a basic setings (wifi is bridged with l=
an interface).
	On the sta, I add a 802.1q device on wlan interface (vconfig add wlan0 7) =
and this interface is routed with the LAN. The settings works correctly I c=
an ping the computer connected to the AP from a computer connect to the sta=
.

	On the computer connected to the sta I launch iperf with the parameter -S0=
xc0, with wireshark I checked the frame on the air, and the WMM priority is=
 set to Best effort.
	I added some printk in my kernel, and the call order is
	[   64.134443] __dev_queue_xmit called
	[   64.137935] validate_xmit_vlan called
	[   64.144290] ieee80211_subif_start_xmit: called=20
	[   64.151343] cfg80211_classify8021d: called=20

	Explantation of the issue
		1. The validate_xmit_vlan function add the the vlan tag in the skb frame,=
 set skb->protocol to VLAN protocol (0x8100) and set skb->vlan_tci to 0.
		2. The cfg80211_classify8021d use these fields to determine the frame pri=
ority, but the skb->protocol value (0x8100) is not handled byt this functio=
n and this function return a default value 0.

	I found this issue with the backport 5.4-rc8-1 from openwrt and the kernel=
 4.9

	With an older backport (2017-11-01) and the same kernel version the call o=
rder is differant
		[  536.195431] __dev_queue_xmit called
		[  536.198922] cfg80211_classify8021d called
		[  536.205799] validate_xmit_vlan called

	With this order the cfg80211_classify8021d work correctly and my traffic u=
se the correct WMM class.

	Do you have any idea to fix this issue?
Regards

Cedric Voncken

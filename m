Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC99377764B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjHJKxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjHJKxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 06:53:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B031704
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 03:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvTcVRdqDZWBUedMPLVNi+inhLlwqHQqXGHjYxbF1e/J6pqHMyejM6ykkaK/wfBTFHC8fMQKkYPKiXmP9dhqwIdSS3rg1TeaMhMRgfb+mnYOJrW41pJrf9MrC9sQ0bijcNY91wdraKd/JHBfpJ3hm1DSwj2m/rfx+eLR6WiWZGk39kbKEe16/osqYKS/Un6vGEOjVHjXyK4MCFRlaXkHJESTh8SaRJYO43rNRguNGNZX3sghZdgCMjXDxxyOBArhHj24B8kVXA35xqtvxdBMG+GqoB00RLrZThL4hliE0chXVFT9TAEJ+++KB8K96sG7eWm9F4WxuZ0xF3G8gzLbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5NaQ7tQTlDYM1sm4Aqcgu6pFyoWz6InYws9avU4ZmE=;
 b=QTJOswO9CxMgEFT20t0kjFP3Q3+TjXYukdpsxVtfBs8hnRRRBZQn5o7PBDKr/GWRsZpS5dWb3NuVF0lzggwXt+DNGnnbAPtPGAGJKdtpWfQHxV6bFiAaUkfY+IraOFhe15Rn+2co+C/O7wLawNLiiahm22DoJhLNMdnOrb0RSEV87BPddt+1U9bGBCwinBXIbIaCNoH3vOEYfzv2k0emLG771NBgUSHa+v2oL4MnGgxUmr7ofKXwFonA4s5xag3+7U8MFXfMRT17j7mzYw/8hjUEPo7FoY60rUcUaBrEUwQ7DPe7WUDkR5k0nUHjci4nvK/+JzXIVqTsfy/zWpndGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5NaQ7tQTlDYM1sm4Aqcgu6pFyoWz6InYws9avU4ZmE=;
 b=rEk16QmnMGFReaV7WSylhn+xAStGh10BBwUe8jhxRgXEKYxGlRvOPG/wec8eLwyyS/eZx02BB/XVZkJOrNuTka16JP/xEgqkiAHvalrdPbhMl7+iKrQ5qZ5CFNFfqznMkX25wVwM3ZpqmKNGzkLsS2e0f8o5Bjx5tUt79XGSNd0=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS4PR04MB9458.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:53:38 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:53:38 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgAPl+cAAAGb/HA=
Date:   Thu, 10 Aug 2023 10:53:37 +0000
Message-ID: <PA4PR04MB9638A7B7084BF1739745FFEED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNS2fEOt1CXLrWLf@francesco-nb.int.toradex.com>
In-Reply-To: <ZNS2fEOt1CXLrWLf@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS4PR04MB9458:EE_
x-ms-office365-filtering-correlation-id: 6e48533f-7b37-4a67-964f-08db99900d40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coHkOmj9PXvcRLfG5KoR9uScHt7oNznc6C3wqzPOg2q1WkJURi+G5KZjWFv0NsvHOVMZH/lqJl/AamIU6060qc0V/7WSBaoJGZK70hxOUqaAOyOXuG+oFm/09QEeg1deK4vsydbtf5SMnLiA5MHU2+FpUmJIqfPhV0QMGCqeQsPguu2qrlI3qQ1WVge/OUU7bYC/WD+2kJjC1sJwebFMLo8p3oObDlfEkLLkH2jbnNoPxugR3qg/7kLXvwx0e5rtlsZSO323hhQBlwJlFvZheFgbRRBCcOlb0fXoOnzs8MJqJM8PNrOqSODaw6iRYnc2RcxPhe8a5JmbcC/GEZSm9gJwuDF3RYxgQ6lM0rat26b3PV/i+qiwYmTRNNBilc/dVfbNDwuLepNYd54ZMC0pnehJanb/OfpWNYs9Z2LWt8kWQd+b6fMifPAiDZezoWFQDljbXnMLL/PCTHLax4L9BmulqZFaHvlO/5dXPvHSbFPTXSlklSYVkmA4GsxxLwH/73wTclV5QqvakEMVkQHGcMOTEAb+tyZAKeC37dbwE0L2LjxScnJM2eobJ/ZQWBhBqhmb3xbLYjBxcZyEwFL5kJRJtEvbrUNtoC7ySgvxM55tNDQvpO6mpBNA9qYVIefO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(186006)(1800799006)(451199021)(6916009)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(33656002)(478600001)(41300700001)(9686003)(6506007)(316002)(53546011)(26005)(54906003)(52536014)(7696005)(8936002)(5660300002)(8676002)(86362001)(38070700005)(38100700002)(71200400001)(83380400001)(2906002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7yn2MuNuuJ/HcsipktKmCtXzc69KL2PyEnVIP0vqpykW5EtVkcFhwWYzlnRF?=
 =?us-ascii?Q?FiSGav2qb46rU5y/NyB2yEMFusSrREM8xsUAH6JW5gg4OfYeOXvqth8wUaiV?=
 =?us-ascii?Q?eYmwf4dj8HA3oryvBCP7hdX3853mM3EJJQnnVGQ60yNaVYy5j2wisJpw7LcF?=
 =?us-ascii?Q?wDYwhwZG3Sx9fX/VoBQwFR6hp3rqxIrokgcQouFQdIw3ULeAC2rkAmYBc3hH?=
 =?us-ascii?Q?il1DOX84l34lnpDLdhuLHlWaC3vtsCW1TV5ufcOWqdRN/hiwse7XqLoNfl49?=
 =?us-ascii?Q?oqP9ulporYEku8j1lyv9ka9K0ArrTc4AOeFOMCbSHfP1y1KDV5ds6riQ5Tqb?=
 =?us-ascii?Q?+1EgrgoajhrcQtz8HUzV5pIJsSSb1vEJANpNikIqfZItbZgOMiqmYXSDF6hn?=
 =?us-ascii?Q?7z4XzPoHr631lwIzgjAUPHUR9eDF9lYyXeTtUR/xnC09Dfa2ivOfFDhcGQdK?=
 =?us-ascii?Q?cMdYZtFBhu5MNVNk0gm4jLNt3/MG1Bz4AS73oVZNsIVuUtADVs4KMCaBM9qn?=
 =?us-ascii?Q?Ya/3X/cKUuPAleEAoozXwRmhaGdMoTpWUyWusIA83ZVgvaGKsjJmCqCdnx8V?=
 =?us-ascii?Q?44Pr72QFwXaIKnirT2e1QiULSr7iQnfzzkwM4G7Cyeg+YsNGIIIcC5rLw53s?=
 =?us-ascii?Q?jVD1ZjTprfkU0+BjiFmQS+cPwLZatGDz5ElioJGYbUA0MMGxlrgki7utAhhm?=
 =?us-ascii?Q?DRzElkFDhC7OPBKFLlWHnDU5pPQ6wYO3wA/HodbGQp8nn6/Ixe10fGXzd23o?=
 =?us-ascii?Q?lLhsjSb+gD1H6FGtY0nvWiG2SZJvCMqrCudUxU2RzJ0dbXvW5tAaZPJhby0K?=
 =?us-ascii?Q?RJiUsYtK9t7uGgObLh5H5BwEMzaDE9QQNLFjH6zb4dxoAUuGksnCllpA1nU1?=
 =?us-ascii?Q?cTcYUNLJf7C3HmrYCu796XZD61HKHJ3AP94KRfndfydKcgvdLJN5NmqZWNUw?=
 =?us-ascii?Q?jePQKtJa+pPKS+i+R4V4PS233cVwMV8Ln5haxvV6eHbDjpH4KDfo3ZgQaDYw?=
 =?us-ascii?Q?6mZXr2m9c67+yr92APlDbIbsmioebmZOiXP1/qNgvBCSkGBEVPkJ9EIP7qgz?=
 =?us-ascii?Q?ETmeMMsG+YbAOEs2/Wf1K8a8e2VaaQ7s9FupFlO64b+6C5y6c37vM3WT/15a?=
 =?us-ascii?Q?fToIG13TE+fLuSiIkVgCzzrzxc+GXk7QSo3u9eLP+HEi1egAoRCzeA8q5cGi?=
 =?us-ascii?Q?vjL/Yvd3dikqCZZFiXDRwrrdgbY7/CYcqz5CJci2L3lkCu72GSvpX42NDxaP?=
 =?us-ascii?Q?RIvkga8OFRxe17fQKH99z/n/lFRLxfkFHR05wBm3DJ2GWvwVDGMy40p5qyZz?=
 =?us-ascii?Q?H0gix+tX4yS5w38yOdaBxdRZxrJj+GtrfUeUzC+U1ag/85L9KQNqa5oioV2x?=
 =?us-ascii?Q?Rp+J64Iykwko8Txj1yDG23auquXQfo2XzuXhomH0MdTpmxHVvGtabMPUDsUn?=
 =?us-ascii?Q?RYiH7YuPykH2rsTR+i/BZbKXgtx8gveTIL1rEk3SDQYcFHoSb2zj9oTfolvc?=
 =?us-ascii?Q?zu7PUvoML85iqkIu3vbQnLrkOeJOSLRjg8De9Z1zikvk4/0TNmT9h1A5mDHC?=
 =?us-ascii?Q?eL+E4yR5Fq5OZA205C40za+I+oKwrU5f+9Bgp0of?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e48533f-7b37-4a67-964f-08db99900d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 10:53:37.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vY48J5/glZVIwqFfF7TUC8VW2VW6JjLrMW4x4zHhXLYOVgXQqy998lFNQ7DD0ghFyG53YDZy2uocgZavwY9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, August 10, 2023 6:06 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; Sharvari Harisangam
> <sharvari.harisangam@nxp.com>; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host m=
lme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Aug 10, 2023 at 02:39:21AM +0000, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. Firmware version 2 is needed for this feature.
> > 4. The code is only enabled and tested with IW416.
> > 5. This feature is disabled for other chips.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
>=20
> please run ./scripts/get_maintainer.pl to be sure that the relevant peopl=
e
> receive this patch.
>=20
> $ ./scripts/get_maintainer.pl --no-git-fallback --no-roles --no-rolestats
> drivers/net/wireless/marvell/mwifiex/
> Brian Norris <briannorris@chromium.org>
> Kalle Valo <kvalo@kernel.org>
> linux-wireless@vger.kernel.org
> linux-kernel@vger.kernel.org

Thanks for your information. I will make sure that relevant people can rece=
ive patch later.


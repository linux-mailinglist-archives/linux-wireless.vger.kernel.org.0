Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD27A35C8BE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 16:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbhDLOaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 10:30:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:11395 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241820AbhDLOaG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 10:30:06 -0400
IronPort-SDR: z2jPtrzwLVDsDMtsc9YttuBuqUOw6GaSW7xb+67ZdW58M49aidc/9o8Sp4RYzAAhiQ9vN5NCx+
 JLiMFI+hjbrw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194233705"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194233705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:29:47 -0700
IronPort-SDR: ObPJoH9a1Wlmw9Fuc5IrwBnMhSZ8lKANyOOyR4Ml+A1bG83bU0Ds+ke+5954WOmd2iPtMJGO1E
 HddFtwPI+YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="420422797"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2021 07:29:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 07:29:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 07:29:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 07:29:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 07:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWLakbHPhjlbgFloIOrCb5GPV6d5Mw7eZW+ai4xv8lGyvTaXnJ4YbSwFVhWZk70WbUcezaKS7FJQraQegawkyxKmK3pYsiF8rP+1AcAk9RFeu+Ehm9aAv4UMein6raVJ9RbD1OENWTYkVDZEtzBHWYvrgxiAUV/Zo00jFOwdm/EIpOeSSHXXSPA+YlGWxBrriUTzkfn58D/bPtaB/oQKgABFsB7pQxPKEWx8PilD04UPPM2OAQwPjCEMXyYV6zQStKI2oiCd2tEGcenp1njsBNPwL78rUjcNVCJYsKSIK0bUtKGFIQetcitBc4lWChhzA0J9amqx9c/Qp81OeU4N+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+nF5isIpHyxoR6JT/Hfev9CbTcxfqYKOE+8MGXc3gY=;
 b=Ikpfoh9dOiqmlHDFzW5RTAHE0NFlYLuZO/kLJ8qGEu2ra5kYxqKrSBIcqc5CO/Vrv1rtb0YHqsVVlYWeCcFHDGBBuWafAcHGMzOz58bJviaObIWSsSVlVJxsnLRut2HZWi7vytH/N84OIQN6CPzp8QShqZINowhp9UKepvqT2QBL7AeD6NRRD8v1tN3PCnJfZhc57COodAAhqY6FSwwaalrVis5p7PrjhzHFl7fbhIRGbbmeDrRghT2c7IEGnwqsIepk2PdZdmLnZi3sf/b0P8Is0EtZo3cWEQDne8GlKDBaU6Flqq0CzVWg+59iNvZxHnBV4zE2Lm4ChXGH55FxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+nF5isIpHyxoR6JT/Hfev9CbTcxfqYKOE+8MGXc3gY=;
 b=Rp2b3tGZhyAcUDLW2XgC880Ki0J82kza/QKT2876r0fZTlIa9v3FH3EXhbqLXwf0ei2CgsG0o91cQncV0Qui8GvYgqA/CyicPFzWwpXK7aCrwaAXwRKHSW1PLl2W3fwbANbk3GzNSC6maXXnc/I8dyr5WJUarorPzYlkSeqy+Ik=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 14:29:45 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 14:29:45 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Topic: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Index: AQHXL5l8AAlmpHtWLk6IhaLef8ZD26qw2g6AgAAEIoCAABAHAIAAAg7g
Date:   Mon, 12 Apr 2021 14:29:45 +0000
Message-ID: <SA0PR11MB475228709B9B0B6D74CE07A2F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
 <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRWtJqbuFGmR2Sw@kroah.com>
In-Reply-To: <YHRWtJqbuFGmR2Sw@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [77.124.181.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39365d74-071d-4895-d135-08d8fdbf6b91
x-ms-traffictypediagnostic: SA2PR11MB4892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4892C2AE8641241CDDD6CF21F2709@SA2PR11MB4892.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QhRugMww9/53iAblZILPaEdo9/FDM9ybmstk9ZfAXasJEhRu1/+HcdpaA5MOZicAvkPx5qy9cvdtLdEpV3ZwTJLU7HBezBysZMsGUFUPOuoDafPyeZNyIeBjKq7NjVXsSYAY9Q+I0UbpyycdiFE1vKG4DjuUw2LMmEZC+MleEqCzdQQKQDd1vOR7+1zdnjCUmhyiizNT4/xiSGpTJsLcP8CycDglM4dWWw6u3ZOH0yB8O4srDzZByPZgTut5tIbJlGK0w2itvJ2JJUKZWUqP0X2TfXiAgO4+O33dWaH7+YOtXDQ9VXTLgZ/mwAAwRl9flFVsY1qHMrhxA8M1J12jgNM0ahIyM5RegtmHMZ861AAsvK80CfNCR7pDNAoIiQdj8rpoCCkSa1yct39sHjOIfM1IqHAcTPM0ASC4CB7hEggWZNQ6oorjDIbwa35P3io+lXTm8CWq2MPI/UqfeXdDnYZyJtgKkjJZJnL4H+ksrvLF1wn4MgVaSUa7W34hIqjrJ8Mh6HA+PPsrUd7vzIIadwxEpmHluoKo8Yu1RDGXMZrJKIZjFEOG8Bwz9UQbC2PI7cUawXy0KustYPBq5Wh8VMwav9XqjYrr2aPDddhzpZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(66476007)(4326008)(83380400001)(64756008)(7696005)(107886003)(6506007)(54906003)(478600001)(186003)(55016002)(9686003)(66556008)(8676002)(5660300002)(38100700002)(33656002)(2906002)(26005)(52536014)(8936002)(6916009)(316002)(76116006)(66946007)(71200400001)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NaWObwWv5mU31anHPpGF7Qf/hmzgImMQYzUNfbrHbfgkS8cpVmE9wGyQW8dw?=
 =?us-ascii?Q?AOjEiAXTmuRsch7B4QY94AoBm35qidZWokvvN+fBmI/M/M/qwJhSXlGDtB4K?=
 =?us-ascii?Q?JT6UHVdGSskJNrNZYUru1bXo2OlhEmRRwirV10g70m/lYEzVy9dodgJ9EhJ7?=
 =?us-ascii?Q?rCl1M6hjH1uvi5q8LANHNcpHkMsE0Hamr9gnz5/2tYyp9UjcKAGINKhSvETG?=
 =?us-ascii?Q?igq3ZWxuGKfK+nWs345IhnUhjW41ur0S9ry79tD9coDg9RItg0fcrRKv9ZaQ?=
 =?us-ascii?Q?YpFIubOw3PRjmMXy7nMz0ouqOFc1tuAcGi9m1pTTsHIo2kDIn9mCsyEIQ12O?=
 =?us-ascii?Q?DetjtLLWyPB3gcnCKJZN5VSPxwNug4t4WnIClDi8qWWBM7zdW6uLz5olNlAo?=
 =?us-ascii?Q?7wb7c5cQP9C4nD4Y2b8UVlL7RurasAxKyUzcDQtoIhBhdVmfVmC9Z6n9m75W?=
 =?us-ascii?Q?gB72jkFPgnxFTzS1YIb/FNCBz7wnHC962nF+v6ACdTi6Braobzl+KaCOztI4?=
 =?us-ascii?Q?PLYpJHYLP2tdsh2A/F7VsUqJ5mnvH+W+qvCh/lOlOll0q//wI2X0CGVA5+hY?=
 =?us-ascii?Q?gX54vOsTaLymlgcyg24pIf03+OX3hAT/UQ9kA692KsIkr9ADMLHr83xKgA3a?=
 =?us-ascii?Q?2YPRJzQUml3XTQtTapL5qVot+Wp3grT5DiUGw95plHcCjnjmWVjMrij7BWe+?=
 =?us-ascii?Q?sf+Jfr7leQIYWY9XVbaYfyKsgNZ6JUV5q7cxHxrl+OMgG1ZfuVSdhx4nEVfm?=
 =?us-ascii?Q?RHlsYd4oLn9j97Mp8t/ZxoqcezPPbPS/YVHh8Brcwu+3rLUFQ2SJMgTRikfk?=
 =?us-ascii?Q?nOZbb/CLbhI1V2ii6ouHPlN4mWIBLnPsVdUDkTiZDj0M5nTYPHyGuuWD2mMj?=
 =?us-ascii?Q?eicgLLVuVXVRa9j1sMF9oVCgC+MXBU3Vl1V8lmGv8k5ldtTugn2h017Do6+m?=
 =?us-ascii?Q?MLd4kKzBb8+3idoUrpzdPijeA//hIdaD7YVcCok2aZY35yMirzSjJnBOked5?=
 =?us-ascii?Q?OhHmVB92/MmAa364ac5VFr5CQBwVdi6YE4nCa869oXsod8ho7HFQ/OqcGt8C?=
 =?us-ascii?Q?Z0JAk72t/qckm6aVRxzsDz6hW/0785PxGokySsrcBxJRCgOYxF+Dj5JfXJtp?=
 =?us-ascii?Q?gJ90XglvcFXZgeYdZxaSCQFGeWf49ACNl9mpH4Lpr3Hgv8+AW8X0cOssMGVu?=
 =?us-ascii?Q?T6k601sLyY3y8lGtl2pjDKQclzq0W3qbDJ/80HoWiFX2KAavgTcfo8RpwmxO?=
 =?us-ascii?Q?+Jbrki9MeJLRlcTj5CunQ1FgKAgPZbEjQOiS3ZBo13gn0nimkK3d/Fb0Pxce?=
 =?us-ascii?Q?YGsoXf7pagobekbzBNaxtO9G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39365d74-071d-4895-d135-08d8fdbf6b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 14:29:45.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlvnIEr+N56odTSmGChka9jay30RXCIR6ewF1VB0hFuCHsHXBCSde1GKBBFw7nT3rWc6GMta2NYvEet5s2fspJ9QNuYVVL66Yx9U9ZAfxU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> On Mon, Apr 12, 2021 at 01:44:58PM +0000, Grumbach, Emmanuel wrote:
> > > > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > > > +	do {					\
> > > > +		CHECK_FOR_NEWLINE(f);		\
> > >
> > > Huh?
> > >
> > > > +		dev_dbg(&(c)->dev, f, ## a);	\
> > >
> > > Just use dev_dbg(), don't be special for a single driver, it hurts
> > > when trying to read different drivers.
> >
> > I took this from iwlwifi. I can change if needed, not a big deal.
>=20
> Please do.
>=20
> > > > +module_param_named(defer_start_message, defer_start_message,
> > > bool,
> > > > +0644); MODULE_PARM_DESC(defer_start_message,
> > > > +		 "Defer the start message Tx to CSME (default false)");
> > >
> > > Why do you need this?  Who is going to set it to anything else, and
> > > why would they?  This isn't the 1990's anymore, please do not add
> > > new module parameters.
> >
> > For testing. I need this to be able to force a certain order of initial=
ization
> which is possible (and hence must be tested) but not likely to happen.
> > Another point is tracing. This allows me to load the module but prevent=
 any
> real operation. Then, start tracing. This way, I can see the whole flow i=
n
> tracing, even the very beginning.
>=20
> Then call this something obvious,
> "kernel_hacker_debuging_testing_only_use_if_you_know_what_you_are_
> doing".
>=20
> Or better yet, just put it in debugfs to turn it on/off and no module
> parameter is needed at all.
>=20

Debugfs is not a replacement for module parameters. Debugfs can be used onl=
y after the driver already ran quite a bit of its initialization code path.=
 Here I want to be able to catch the very first messages with tracing.

> > > > +	if (WARN_ON(rd > q_sz || wr > q_sz))
> > > > +		return -EINVAL;
> > >
> > > If any of the WARN_ON() things in this driver can ever trigger, just
> > > handle them normally and do NOT call WARN_ON() as you just rebooted
> > > the box for a simple thing that you could have recovered from.
> >
> > My understanding is that WARN_ON does not reboot the box which is why
> it was invented when we already had BUG_ON. This can't be triggered by th=
e
> user space, but can be triggered by the CSME firmware that runs on the
> chipset.
>=20
> when panic_on_warn is enabled, the box will reboot.
>=20
> If firmware can cause this, then properly handle the issue and continue o=
n,
> don't reboot machines.

I'll print an error then. I still didn't understand what's the difference b=
etween BUG_ON and WARN_ON in your eyes.

>=20
> > > Some of these WARN_ON() in the code feel very lazy as you control
> > > the caller so you "know" that this will never happen.  So don't
> > > leave them in, it's debugging code that you can now remove.
> >
> > I can transform them in error prints, but again, my understanding is / =
was
> that WARN_ON is ok to use and won't reboot the box since it differs from
> BUG_ON.
>=20
> Again, panic_on_warn.
>=20
> > > > +
> > > > +	IWL_MEI_DEBUG(cldev, "Got CSME filters\n");
> > >
> > > ftrace is your friend, remove these pointless "the code got here!"
> > > lines.  You have loads of them...
> >
> > This is debug. Won't appear unless you want it.
> > I have extensive tracing support.
>=20
> Again, use ftrace for tracing, don't use debug print messages.
>=20
> > > > +static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device
> > > *cldev,
> > > > +					   const struct iwl_sap_msg_dw *dw)
> > > {
> > > > +	struct iwl_mei *mei =3D mei_cldev_get_drvdata(cldev);
> > > > +
> > > > +	IWL_MEI_DEBUG(cldev, "Got ownership req response: %d\n", dw-
> > > >val);
> > >
> > > Code got here!  :(
> >
> > Same, this is protected by a dynamic debug knob.
> > I can see tons of those in mei bus driver .
> > $ git grep _dbg\( -- drivers/misc/mei | wc -l
> > 228
>=20
> mei should be fixed as well.
>=20
> > > > +
> > > > +	if (!dw->val) {
> > > > +		IWL_MEI_INFO(cldev, "Ownership req denied\n");
> > >
> > > why?????
> > >
> > > > +		return;
> > >
> > > No error returned?
> >
> > This is not an error. This means that the CSME firmware is not allowing=
 the
> host to use the WLAN device.
>=20
> Ok, and what can a user do about this?

Not much, but a kernel developer would like to know that it happened.

>=20
> > > > +	if (!netdev) {
> > > > +		IWL_MEI_INFO(cldev, "No netdevice, dropping the Tx
> > > packet\n");
> > >
> > > quiet!!!
> >
> > This is actually not a usual path. A race is happening here...
>=20
> "race" implies "error" which is not "dev_info()" material.
>=20
> > > Or at the least, make this an error so that a user can handle it
> > > properly.  They can do something about this, right?  If not, why did
> > > you just tell them this happened?
> >
> > There isn't much I can do here. The CSME firmware is sending a packet
> > to iwlmei to send on the WLAN link, but the link isn't valid anymore.
>=20
> Then report an error.
>=20
> > > > +		if (le16_to_cpu(hdr.type) !=3D SAP_MSG_DATA_PACKET) {
> > > > +			IWL_MEI_INFO(cldev, "Unsupported message: type
> > > %d, len %d\n",
> > > > +				     le16_to_cpu(hdr.type), len);
> > >
> > > So userspace can spam the kernel log?
> >
> > This is not userspace, this is the CSME firmware.
>=20
> Then make it an error, not an informational message.  Someone needs to se=
e
> it to fix the firmware, right?

Ok.

>=20
> > > Please revisit _ALL_ of your messages you are printing out here, it
> > > feels way way way too noisy, like you got the code up and working
> > > with the debug lines in it and forgot to remove it.
> >
> > [   12.665966] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865=
:
> Got a valid SAP_ME_MSG_START_OK from CSME firmware
> >
> > That's the only line I am printing by default. I can remove it. I can't=
 do better
> than 0 printing.
>=20
> 0 printing would be good.
>=20
> > > > +}
> > > > +
> > > > +#else
> > > > +
> > > > +static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {} static
> > > > +void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
> > >
> > > This type of thing goes in a .h file, you know better.
> >
> > A header file only for less a handful of functions?
>=20
> You already have .h files for this code, why not put it in there?
>=20
> thanks,
>=20
> greg k-h

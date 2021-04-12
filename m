Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3478635C611
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhDLMUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 08:20:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:53983 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239916AbhDLMUO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 08:20:14 -0400
IronPort-SDR: XYnh472nwT4BTllZ/r6Au0aHtr1IUOtHY26MV0qZI2yE7DjicrBTeRzdwx9YdbtGdHWtBrFKa4
 snI8c0896qGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="190988893"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="190988893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 05:19:56 -0700
IronPort-SDR: 92WOJsGOlO8EadHGdWu5k54QalL+3nV7pIlYckGORsfY/e/qYCus4zQBVNgT3JCF0Ep+o4o+L6
 KIeEFx+Jg2RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="417362333"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2021 05:19:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 05:19:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 05:19:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 05:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PycwR7wQYajDtcsi3W57ceM5IVZw09SHU9wDrbKFSXLicDpKEEW8fKkdY77+TqsFKUkO7svgyYunmSv50dha79WeBS5k7AHp69F5idq6IWbtrrfDuZkMAHFiqcfPELAhS0etYK7gvRqWdUro0cxfUQa5tgzVoxhaHTU05Mkqk5ug82SO7R3SfENQDm4hkiaB/fNz0umA6oFju640iMilN/LuQMTEY90Hza+WeZjuARspEpiLrnZk4QU7NjZ88KWHhVnMhquqgXWDKqygMj0OYgengKQyL964IAI7/seH47HLNSVfhUQ9zUSgOir+1V2X14ERClsbdjnaG0D/vRUqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nYhOnnXbfsoFzOZBu41nKTxefL2cltouhiMesVAiA0=;
 b=U5+tyHhxzKoFhL/JT2yD/KllwVKKymGPz7utMpU+Zg7wI5AZF+kUaINhQB51I1pVFD8952+lk6PPyoNhmCL6S1E53ITCIgnEJqFBlcvLL8udG2LbOxFqaBxqdS4FmJ634+9/3FU4R7ImMjGloKWzX7+cLcgLP+fCIiS8SPvYBrWenhlXvUaJ9Ifb5H7dY8gWxgAOu0vL03Rnw6Saoc1wf7EjxhMAVpPxOiLC45NL/srVIUyf7LgAmUJCAAILDMwPgw8zQw18e/ThpIriD/ZJT1adt8ozpm8yLftzpgzGIbtwM4y/Nuq9XOQtc5jHNqVsYYyW0Ncb19hJ1cVxntfSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nYhOnnXbfsoFzOZBu41nKTxefL2cltouhiMesVAiA0=;
 b=b4RV3VB3ohbz8yepx+6PB9NizUGs/5ywloba9QYn6n6UOB2g1R42K7DXyOzy1aAW2aIS3LIMKhS3oTZFe+rajTtt/HKyr7X9HIZlNkr+Zs1m/qAhUrLFxNtqQhEuKhKA5grIwK6+athk35nvLs9+a+E862r2RbGwL6Id79qtXbY=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB3134.namprd11.prod.outlook.com (2603:10b6:805:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 12:19:52 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 12:19:52 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "'Greg KH (gregkh@linuxfoundation.org)'" <gregkh@linuxfoundation.org>
CC:     Kalle Valo <kvalo@codeaurora.org>, Luca Coelho <luca@coelho.fi>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: pull-request: iwlwifi-next 2021-04-12
Thread-Topic: pull-request: iwlwifi-next 2021-04-12
Thread-Index: AQHXL4nvuP/xcvCmYUO1k2ZddBS9DqqwwyYxgAACUfCAAAZKAIAAAGqg
Date:   Mon, 12 Apr 2021 12:19:52 +0000
Message-ID: <SA0PR11MB4752E3834B186ADB27F2B75CF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
 <87v98rlod8.fsf@codeaurora.org>
 <SA0PR11MB47522E7EC6ECE33A9D1068BDF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHQ5sjnH2tj8Jvrg@kroah.com>
In-Reply-To: <YHQ5sjnH2tj8Jvrg@kroah.com>
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
x-ms-office365-filtering-correlation-id: 8621d880-f533-4d37-7d78-08d8fdad4646
x-ms-traffictypediagnostic: SN6PR11MB3134:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3134B9CE492454B85A8090D5F2709@SN6PR11MB3134.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMeHatvcAsIOq3WErU4DCgk7joGWw2pFfsLVTRmIED6SCjtejcC0LzZKs5UnXVjQAA3+h6W8cIxgKmM/LvRt9uplKQRKMZxC8T2EZUUwz/jf9YbVK2XmctylVp1V77HdA5HrNPZBK0o4QTNys2p82W3EOYIu3rBHjbyMK0tQg3yN88Q5I1+c805hlnnT8rTyST6kBC+UL1l0ESowcDYxEyiglMa4PW2MPvCt58CbpT4VFbsBAKTTbFgP0I6eywf9xyWR2F2Dm67v7aOI7egE5h5BhN/DzBPM5ut80g8L5uUD9i2UIjzJVTBJNKs4GgulC73Yl0qcS1RSpYIzFzQiifi/rAecL8DC1icbTeqAMY8GyzcoNG5L1E99kgjpEQoJfzdOi/0yda7yzunZHcJlmC0oD36qeoSUdZPPAAjQZ45W+c4qmuPn7VUZUbt2I91OB9ud5ijjNeo3eTg4lpTvirIs0jBufAXomv9zh4mi5L9r7EPztdoHOjoBCUDzIfFOsDrVgopX9GqGu73yO5eDZMPL01YzTziJ4avFmJTFYNeTcInvqmS/6/nuYh+RwzelaSer0zHdBq0rGq0MFpVvuJHsy6BAG71C8y/9+ALtBlHYpUWaf8FhmFn5n9MtPh+zwFkbrWwR80G4ZGZyXj6CyKfgKpsVGDqQa/i2XkXc9rQQ0C0S7gRuGajWJ5dbB6Ag
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(83380400001)(186003)(26005)(966005)(66446008)(64756008)(66556008)(8936002)(478600001)(54906003)(316002)(7696005)(2906002)(38100700002)(66946007)(66476007)(55016002)(6506007)(8676002)(52536014)(4326008)(71200400001)(33656002)(6916009)(5660300002)(86362001)(107886003)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OqlAfCSXsTnCgWGbUcL0plgmk4qJbWxfBDQUHRWOL35HKlX1y0ZkQiI6drX6?=
 =?us-ascii?Q?ey3iD3yLmBYjQvECbxnlpnuj2f6jHHAaXEDKAJ0Lz2E4kzjlg0kX3kmXqRrZ?=
 =?us-ascii?Q?q/i0XdFdWQ37lXhsBJ0zxGlWEx/whbF6eqXpw43uvHSnayzI9Tdpn7+cUlpi?=
 =?us-ascii?Q?VsUjCFNw6Rnrxuf+qYeAuucFpXBuI8npzCE3zO9v+CkGgcdem+NnxXYlTsf8?=
 =?us-ascii?Q?N5t9MGXdCf0gGwA+ftNjpq1KMNJ0Bo0GXTAclX82AmxejFKMri13JtmLEyNA?=
 =?us-ascii?Q?6+QGOwFxQcjS1gqaY5mQufNBAyHu5RvErIey8WwXxm7hZdzAxr7gU7E1d/zU?=
 =?us-ascii?Q?kSKXYkJc+Up5iRwiSSUCB04j06C45hWJ/z4rbwQOT+mFCwu4rkC7HenhHGDQ?=
 =?us-ascii?Q?H1nosUQt6CCQAML62B8aw5juUF4tuQVRnnF1In7nVvCHcf/QAFs6fIpjvcuc?=
 =?us-ascii?Q?sZF/SFBixF/wFBCR7v3veA+CKZeHhI90tPZh3eJLu6GspX2u93ZpHEI3qya9?=
 =?us-ascii?Q?2hstHemy//LkwpAbhObJtVzljWthN2ZQ7ziY19HVxiZNGWTfHogE/eCOMUkW?=
 =?us-ascii?Q?aueXEjNbX1BoRILpZNBYboxqaAOMygDET0/r2ttj61vckQRlzzTEYRRY/bso?=
 =?us-ascii?Q?MsnkuGo6dYqlWDT6GZBvg+j7OAfcUiZN0qO326R3dOmYFVZm5DpQ7uWe7Qaq?=
 =?us-ascii?Q?NIJoHso1gPZ3w2k/dzYZYsaCi3dybpm32+s7PFby8hpNEbPq6Yy0TmRO5wxM?=
 =?us-ascii?Q?dRT4PjqpSCdJYrTcV8H/yRSCu0dEHNz3MfRJB45Alwmt1PsvPiY1E8XkIXFs?=
 =?us-ascii?Q?vFL5B9n6XPFrksW40ybovKkKDAiNZern+iahrXbinMTkjDUyox+N1BZGjf7R?=
 =?us-ascii?Q?wmiEU/oUW0gS/ZdCBIcjYruzrsN6Rhl/IAgmjplzl1xU4cTzz44K8bprcIgX?=
 =?us-ascii?Q?+w1aa0v1TrkF7VKtlb8lgxRSFB7/SW9nfNEOFHCqBgiT05T562o5rQG0+B4p?=
 =?us-ascii?Q?ZChaW3cGQUBMNag3aPPomo83akL1HTBAbyJcb6jnt+5IB9NZA0xluBmV6rbE?=
 =?us-ascii?Q?2bLEFYh4SHZaNNJupPe1aYt6SUgk3fHdsMnfflohcl1dr6x6uuYphxWLRjLm?=
 =?us-ascii?Q?NAaElzSQYFRHN4O81xCzY/6E6B9EaY0lA0nxXFZlfxCO56ov24A5R70gsxbd?=
 =?us-ascii?Q?lXvZoN6UgcwGzdGF4sHIvS5pIOA4IMue1/vmzXVNksZOh+8BRpdRUXe7cyAP?=
 =?us-ascii?Q?trLZ9rX9gHVcew7jH8871vOAUANRPGqnRm8RY/l5XfjMZR4NU+lDKrsPRC6J?=
 =?us-ascii?Q?63JN/XJ8iEcKJ2yZyZTMXxqJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621d880-f533-4d37-7d78-08d8fdad4646
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 12:19:52.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2P4kRG3WQI+AVnS9BsG9RCKnEZB9E/zS4IZZU5+BnUKOzKWTIVmalBZFa3cv8W1BXGt0zXhxqP7sS+Tz7f/k4YjN57DpUxTTWtU2sUOMsbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3134
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> On Mon, Apr 12, 2021 at 11:55:23AM +0000, Grumbach, Emmanuel wrote:
> > + Greg
> >
> > Hi Greg,
> >
> > >
> > > Luca Coelho <luca@coelho.fi> writes:
> > >
> > > > Here's the first batch of patches intended for v5.13.  This
> > > > includes the four last patchsets I sent out for v5.13 with the
> > > > usual development work.  It also includes Emmanuel's series for
> > > > adding the iwlmei driver, including one patch by Alexander Usyskin
> > > > in the misc drivers
> > > directory.
> > > > (which Greg asked us to push via our tree).
> > >
> > > But no Acked-by from Greg? I would like to have that in the commit lo=
g.
> >
> > Not sure if you remember, but Tomas sent a patch to you and then asked
> > to route the patch through the user's tree. So here it is :) Kalle woul=
d like to
> get an ACK from you. This is the latest version of the patch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.g
> > it/commit/?id=3D1b1910e2c82ed5392b90470885d91f3abc1619e2
>=20
> I do not remember anything like this, do you have a pointer to the
> lore.kernel.org thread?  Remember I get about 1000 emails a day to do
> something with (usually ignore...)

Bah, I forgot to add this link which I had prepared to paste here:
https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com=
/

>=20
> And I can't review a random commit on a random webpage, that's not how
> any of this works, you know better.

I guess I can resend the patch and CC you to it so that you can review it.

>=20
> greg k-h

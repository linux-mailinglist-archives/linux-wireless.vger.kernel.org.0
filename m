Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E032ED50
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 15:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhCEOkj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 09:40:39 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:50945
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229854AbhCEOk3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 09:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwnM6JfjMqm0+Da3Srgy+naCcoXXJVVrvPLT0fRKOEG5cZlA8k4Eb/tUwC9GzNYLE7S12eaFbBJSdOG0dQnlTR5KS8httxqdCRsuRJv8Alt8swx71O8X5ID1FpDw88aDf6FQb1ODnjBMY9kkNTP0YSEk51G4kFThBOppNeX+BSr6TV8VW/0yay3tNSEezvVZnk478YjiiNUUL1r/l48VgqJmaaGN4yQUkYx68Wg/cr9O0anESWMENvAQiO4rw1Y4eBtYptkf/0njYu61biXfXkcUbeFJ+21sJaM6OM+tZq0sCLPT9IaaAYfmPetdCCjzxj3RNE241s9uRki6S9NtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbS7Bwh1ThkAUVsQu5mWhX8flQ2EItBrpjzYhxPjF9E=;
 b=MbkUryLYLE3LusIReAvhh1pCoxuriFLQzs0NaKfSjAc/jCUukN2Rm93FC/ZPuuZJt98FK5qYsJR1vR+1GwfpwifZ0J6DJOPShamUu4HZ1/zfMr3dvTQHrzon0kuQwHe3x5l8pRSPvnYNbX+Icez8sSI44qVLUtxS7hKj/logK918bFcImhakKkm4NrWxiYxsvQPXcwwqEDrhw0ES1Oc2GugRo/t1znTmivHFk3RkohnC+hfmIMPWdlluaDwImaMxlqTNcfJ79tWm2ud0v8g/v9dYOfPPK4jdF5vyUHV7+ZnoOrAAWNiomqdYg5UYosasMKaolh9eEMy/KhPH2Kr2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbS7Bwh1ThkAUVsQu5mWhX8flQ2EItBrpjzYhxPjF9E=;
 b=I1xAplH7V5Tf/i35okxpAvlV7eH7k8z/yBW4U0IHjPcaFX4LXJt2FrYlzyp3yeiHsjxNd0Meiz/MkHIPZDFsAvMd/m2WzWcmmwQ64WqcZCieWqKLz53tJBgQ0wJ/JkgHaXfSw9lQRW3RyNxxpOERH+83FvOtk/nJ/oJx27LjMpA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2558.namprd11.prod.outlook.com (2603:10b6:805:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 14:40:28 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::41bc:5ce:dfa0:9701%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 14:40:28 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: pull-request: linux-firmware: silabs: add new firmware for WF200
Date:   Fri, 05 Mar 2021 15:40:23 +0100
Message-ID: <5944333.eMMS12kUo3@pc-42>
Organization: Silicon Labs
In-Reply-To: <CA+5PVA62OvSOkdw_x=oGgXHcD1y5zz9cf0cdthKgGHddH30eRw@mail.gmail.com>
References: <2833354.gXvVfaC4I7@pc-42> <CA+5PVA62OvSOkdw_x=oGgXHcD1y5zz9cf0cdthKgGHddH30eRw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by SN7PR04CA0154.namprd04.prod.outlook.com (2603:10b6:806:125::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6eb53b6-b01b-4c7b-b25d-08d8dfe49eba
X-MS-TrafficTypeDiagnostic: SN6PR11MB2558:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2558D16C7363AC5D659EB74793969@SN6PR11MB2558.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpNpg3aaBDOhwpkPP1lv+BiI5mLqt3TR+cbQlYTq7wibANAofw6ShxJq4FKaQS/bh5bcpPRoSIn63bzIRNWaj1XmZrmNooUbwQAf8lG85IzklFNQHlL8dBMS4fCyPz8HxiDeqi5E84p6jtkcJNQIkT0XIYIumZs8xe8FWV3eytqaW1yHC+L66YaLA/fQ85U6o2gAOfYm0LVRpukqRj/tdV5WxEKvBQZ+zGYJNkLCpKSyGnHyI7DqVuumtVLKsrWd/oANGWsWr1h5U6KciGllXY+cuURLC+lv2Qgg78fz74MM/YphlrRbgMf9nxLZ5KQsDYMr2I+/HbQpALOvk6HZFqoZQdNT+5BwBtCRfEsvrLITFnc3hZkfACod4mCQ9wV63hsBWZIJp6ZW5Fz9APVaQ/lg2WK8IAiJVuCoyHmAKdD/WelfkPqYsu97ZFja+/0c21o7z9bku/mrT/DW8M4gciKrZ96EatENrpxo8hbx62I6eWK+fbdFFPh9PxgjbbIkqewuitvR9KAB0JRoE5kfW7YB3Ao9XffOBBynHEBAGjbhE+pSeMlPSFyn1YV+/JISJbA3cXEuSeXo0OD+8lg58w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(376002)(366004)(346002)(53546011)(6506007)(8936002)(33716001)(66946007)(52116002)(66556008)(66476007)(36916002)(6916009)(8676002)(6486002)(478600001)(316002)(86362001)(2906002)(186003)(16526019)(54906003)(4744005)(5660300002)(6512007)(6666004)(9686003)(4326008)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?4SZd+DW/DcGkvh8eAMa0959rdMpYplRqU0EI94UjA+WUkqa91xO7NmQObd?=
 =?iso-8859-1?Q?Rq1H2fLPyd4bYPOWFbHe652/ZOgeC0B6PQ8zHnfE0rDWVVs17Gvtx/cMIx?=
 =?iso-8859-1?Q?6a7/76+h/KioKpTu+zFavvmQ/nNMDtj54IvV//Ve4N+Avs6gLkD0A1Vmm1?=
 =?iso-8859-1?Q?rsNwi+pBbIUb8ugRKrQJiiwGEbG5WkrXGNUtVXae85n1+Yv4+mvjDy4Oog?=
 =?iso-8859-1?Q?KwCRm0JPHW3VNB2bSfsReYzetzKTv0zJ3EvfUYRAU+52jgJwY6WhEg0K0M?=
 =?iso-8859-1?Q?N9mIIaDGsfpple9w0j5RdqNiMjHC7DGYxr3G6QI/XtU7ZCBelQxm/5lgA6?=
 =?iso-8859-1?Q?Uy8HSSjTv7AoRSx9qZqKJYHEdeTTlvvPz1YQ5eGHhf12YAQiyvSB5H5tEf?=
 =?iso-8859-1?Q?fyh/jEpoXnknvr9KfmVeh/y6WT1NUEpkBLXrLXG1IY2SGjBjIjaoM6Act4?=
 =?iso-8859-1?Q?PhZlo6d3spGZauIfwFQLgqxH2be2CBUNPOQ3di/pB9PhntLp7e4mQBY+4p?=
 =?iso-8859-1?Q?gVBeFgUuesNdwa3R+sKfTUJbVaxiKnrsg4vIYchikXsrgdXOo04PGCCG3L?=
 =?iso-8859-1?Q?oiZ0aM6L27V2ogobwhpwJl+vTSdmaLuG3NDuyfaWyePs9Ic8M76FicFphe?=
 =?iso-8859-1?Q?pMU6FWnMbUxRIMbpYcyKs18ztdC4jGT8EbC7IFvqYzrzMMRAmPBX4U5lKE?=
 =?iso-8859-1?Q?7ubs17Ftwt0Hnx4uAFdQPp9R7V39z9EPjW+UxXWt35LrYu1r38PRVTGoNH?=
 =?iso-8859-1?Q?usnKkYzNUReIIakzKoK9jh9ym+wD0i2y3t4BexcRWSy1aXWjq5pwdVobye?=
 =?iso-8859-1?Q?ePOYC6IjxTe8f4DXS6kjBGCRU6MCIKSFk6OVWBQaCI8t5iPqqXyH6WZV8Z?=
 =?iso-8859-1?Q?eWL5Kw4b3JnQsQZD7jRJ9r7N2y4aYA16Rt3D3zPTE9rB1bGUrsDsGngwhT?=
 =?iso-8859-1?Q?0AmD/ZmVMnRlkGQ3CTG0I6d1YR2Z0iRzUxTVF8SIjJ9UxAqn4bt0GEEy/Y?=
 =?iso-8859-1?Q?iUMz+zhVAS6Kx7XXgoHQScjU8qGx/hGWtaH3PNzgu5goHeWWTZ1oKFqEXP?=
 =?iso-8859-1?Q?5cddKj/2uA9CiT+R0CCzNGYBKXQjToP+RXqZ4joERndnOSPAy6+Nb2KKTN?=
 =?iso-8859-1?Q?nGtglUPJkBvoUZkzQCVgYU329blFnS22m0JPntGypgbh6Ktrl6/325AEwE?=
 =?iso-8859-1?Q?0TaXMb5Koi76WZgPWDc6+ihr2hhIaj0tjgisPF3HjY2U8i4GlV/H25hbGF?=
 =?iso-8859-1?Q?jM2609Um0uYVbQzTbJJLWHXmc8UYyyWWymByBBD9fzfM8qKQ7xshkwxyVd?=
 =?iso-8859-1?Q?0nu1ysgKh8qBj2cGNFYrB6jqzoaqhSav6FAR2suPD1avVCQK+jaJL5ccd+?=
 =?iso-8859-1?Q?1q5ac4tE93cb9gugjSWrOM1R4748332auar6u67ltkuvmQaXhhHv/nqCcG?=
 =?iso-8859-1?Q?5Xrbt79d4PmXwyJV?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb53b6-b01b-4c7b-b25d-08d8dfe49eba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:40:28.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijjplQICGNy9+ZdsnquiXYlBI1dpn0z1tWjSp84sRT2s4lGDNiin75naaq7iXWuMvoUKgwCNq9cooqA/hNsDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2558
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 5 March 2021 14:08:20 CET Josh Boyer wrote:
> On Wed, Mar 3, 2021 at 12:27 PM J=E9r=F4me Pouiller <jerome.pouiller@sila=
bs.com> wrote:
> >
> > Hello,
> >
> > I know that PRs are less convenient for review, but it seems that my pa=
tch
> > does not want to reach the MLs (because it is too big?).
>=20
> I got both copies :)  I actually prefer PRs for firmware because
> otherwise it's 1% things we can review and the other 99% is megabytes
> of non-readable stuff anyway.

Why the hell they do not appear on lore.kernel.org?


> > So, this PR contains only one commit. It adds the firmware for Silabs
> > WF200. This firmware is necessary for the wfx driver currently hosted i=
n
> > the staging/ directory of the Linux kernel.
>=20
> Pulled and pushed out.

Great, thank you.

--=20
J=E9r=F4me Pouiller



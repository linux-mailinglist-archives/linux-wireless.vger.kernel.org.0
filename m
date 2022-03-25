Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665DC4E6EF4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353861AbiCYHgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350208AbiCYHgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 03:36:03 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DFF53B7E
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1648193669; x=1648798469;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eVBM3w8Nf7cPi6ck5cd9+kCTHXYuWCGZv538KoGpROc=;
  b=S2z3jFDqtyWYUm97DdxE7GYptflil8q9r3vbQbJhIFn5UYHGQIDylbYZ
   hFnBG/3aybPLTzI/N7Sz6rCsfhylnqhdBW+/iqzPoOqHt0FlRCGBQocz5
   ygwRX/cVSMgM0OOHktVUgmRLZ9A3Fa/LXIlL3mV/4TVr3i9tqXVFbY6C1
   o=;
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 07:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGvs/WunHtPMx3Ln2RpBt2Nwn+0JTc8Nm+MIsiIMACtxrKwcs1ignGEEYtNlxIh7e3GY3Vr3yWh+y8VJq1rwBWyrdX8LrJ7KIAHWBYz5obNUWZttP3ngISsQ5ORUCyRtXvVD1VrS09yo7igQEjvRnQvclqMVFv2Esb9Sxm0lukRZ+vP1sM5jJOL3YmU6rSzeju0Tn+j7+XiPQu0mcu99fF2AppZDjp11B2aYHRZG1t1oc3a53Tzk6oUxNhUZ2TN47SVGfdBe4UiQ+lzeqUui5BSOOoedDpk2WQjhzvzVyTnxEqrTlfdvNqSgjhCZuoFJtCvycacSWjFLSWFpvsEyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVBM3w8Nf7cPi6ck5cd9+kCTHXYuWCGZv538KoGpROc=;
 b=j/NrROk6IPO9Alr8a9b1x+F3SYgrkxd6YoHuZTHMBhzGFb17ZZbdw0nbPBryedxJOwqPPz+yh3LriBek9T33JtsVA2qDcSma/O4l/atMi2FsyuOSCnSN58LtiZyo6SEIbWvph8ttpZND7fWLAOfOfNhEceEC2AwbCQFncZmMKELjZli3fk+5EnHI/nVu8FkqMKvw+us9HslxpaKITSOcBzJe4xQDjGDVNuhGcfLfM2rga+lTj107jT1SbA3ai61ucHL6xQC5xNWiE0JmK9jG/f+iW+Y8AVhmXgncdP+c70sHXldEoW/J29yNcP0sOLkm9XfXfJwWAK3hQZpzpVLDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 BL3PR02MB8020.namprd02.prod.outlook.com (2603:10b6:208:35b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:34:27 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e%3]) with mapi id 15.20.5081.023; Fri, 25 Mar 2022
 07:34:27 +0000
From:   Rameshkumar Sundaram <ramess@qti.qualcomm.com>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: Recall: [PATCHv3] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Topic: [PATCHv3] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Index: AQHYQBrBgUfvHRjFp0ep8BLecnFfXw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 25 Mar 2022 07:34:27 +0000
Message-ID: <DM6PR02MB4937B7DC9B6609463E435794E91A9@DM6PR02MB4937.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0af3bead-71a6-4be2-6eba-08da0e31e447
x-ms-traffictypediagnostic: BL3PR02MB8020:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL3PR02MB80200D6BBDD3ED2E4A8B7437E91A9@BL3PR02MB8020.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhO9bfc2krLeVXPk2rRi6w3gdmA0ll1mhKXgr+lrqtL/m9SGt4Va9ZaTa/3ormGebwiBAIHTUILu/E0ZAOQNitk03B4m7bYL27ihd4iw41UpglRIql73cIjOTjXFCzG2bQUo+dxJbdMRxZoM9py7Zvx0bNp3g+v0K2jY2dvraH/df859Ctjp+6XKQdZmbMocxeQeBtzuIQu81exQfhT/5VgKnjtl2tzNzPkPr9s0ZlVEEIvj8DPy43S1ZmZCNVZIXMl/C/V5qdj9qnycrTFrmR1l8fhF7jOJR+oNxNSsHO7lYKQTHZACMPZieOkfw14M8I1OboqxKYlBH8IvT6obxqH0Mi2k6wXawjk7D0JJO2/Tku9Su1fGSw0jZatBVjNkXeVQLt/8+md8PHrtrm5IYLW71m09NPVSjlEuU4ShnboLB+bChV5QmM5HaB0XA8kegs0oSrNCLH76nM7dHl+k88edYEaBDU3gwGnB6WprF8KZNsr3NVSXwwuUjtSjmJPwT7eK1sVgcwFroMrfHgf8chGFQLE/Bpa251tDABSBvTd1NTJooIqLOQsXiGzJpXCL57YO0MXqbK43j+4i1+nWL7sGSd9RDydqxqVC+XltLxQoXHnu018tGB4sRcBiOyr6Pi6iCHEv5WYt/FydAp9pLs9y1/KVXJi4c+uk+ck455w/pNNdgPMQJ4GeYHBilpZxxu7tknvRRtSk5p4Qfzj2tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(5660300002)(52536014)(8936002)(508600001)(8676002)(66946007)(4326008)(66476007)(64756008)(316002)(110136005)(66446008)(558084003)(33656002)(76116006)(55016003)(54906003)(38100700002)(2906002)(9686003)(6506007)(7696005)(86362001)(38070700005)(186003)(66556008)(83380400001)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IRt6ftdVdcdt8TvUx0h/+VSScBCo8oH1ltJ0natOV/WHycihMRrk3eroHc7X?=
 =?us-ascii?Q?bOMdlfuUW8gVjPiHYhx8kKiE0iSAbE8v0Tx0QHOQrIW5pXPgXHhQMWtKsy4q?=
 =?us-ascii?Q?6aGAWuIm+rVA3x12g9tyfjhCIOI4e3Badw6iMFdvGjkGM/fZjqcWYKKdlj8N?=
 =?us-ascii?Q?b7D654suxfQLKxn9+gWvtXcXAGvabqfrXJilA7j93gXmu9hiUTco2w2BlT8+?=
 =?us-ascii?Q?+R/06PRPtQ0noIXU8pT/4DrPNFEUPzyb+XCfW4wtyxnFVbrTkF1GiYn5Rf0N?=
 =?us-ascii?Q?S5+nSFNhe08lqZdW18J9xLK7Haw06ayp6ycv6rUpfYvVuWSqv2dVx0yAfBSd?=
 =?us-ascii?Q?W2MO1sSeFsOx8fYEFf8DKfjDapgA6f2TwQnK7Z5u1TTpWxGyFYvMrLEYHyTg?=
 =?us-ascii?Q?SkJ6x9S32Lb/DaxP1NH5ungh7J789yFLIXgGngHghS+8/0RjO9E3pEuK95ja?=
 =?us-ascii?Q?PahyonuzuV2hKHaqf9/ET0q8B2jxJU1GSXGR3P3h21U+20W3mVkToDzU8qiz?=
 =?us-ascii?Q?stTx9VUA3l6MoGQxW+YciYnh1ydWlkWnkJKNfqHfQKSKoOLyxBkKELUf2Ewp?=
 =?us-ascii?Q?zsCRrh1x9qYAu1MLBSH68d+CE0p/IxIGB1N9tjnhVqqlPOb+cuRuTleLk/wO?=
 =?us-ascii?Q?P79ry38/6c5EIhD9lW4/0WhxwEBNqx6GCCb262swdkAzNge52AY9W+98HFUA?=
 =?us-ascii?Q?PJJqjU7kkC49iS4eRZWveFV09uQ1i+iVpvz+R5TwpqIwBYZe/UCXg7wPZ3AW?=
 =?us-ascii?Q?Wg2fjnUxkoqWT3eYTFlX5zNhOjcSmFULzsMW+FDJku8YYyS+Ch3NviTJv/FC?=
 =?us-ascii?Q?b+QjHjuf6zIoqwTcrnZ/mkUGCmM0YdrQDnAgMDWC13LQR+OId79CAgP+ZI/U?=
 =?us-ascii?Q?uLnufxZOIgAbeicGbwtT2uM2lg2C/ir3g73NpBy6teMRJTUZfXmSYjkRbovJ?=
 =?us-ascii?Q?Bt148xixMidt8VqsKFla5mxuEUWMR8K0itm8wTbHbYdREDtx2xI3r45kMV41?=
 =?us-ascii?Q?+v971vpCgwb0b8DVGtfxlMbSINZcTQTcROuv2oNMnaM3A4Ms/EzKZTHEzjkN?=
 =?us-ascii?Q?h+Z+eJIhoZmZBVSu6Wffi0dStdIWWd3eRX6TNm75pHlXnzBmnO5NBpifWUWB?=
 =?us-ascii?Q?Ur9M0MS7S/OkFPfhHIbePZziuVsfzAK9E9tZF5FAWJ2B1a9tWdg/YclzLK2B?=
 =?us-ascii?Q?hzZoRSGuOhvgkD4tSYwE/GfBoKnMcot/XL+F9OQk7EETGuno6MKY87xIvW0q?=
 =?us-ascii?Q?mvR1YHb7H4IkNq4kmWCqU59rQib41637PiMstOymWnmiccmUmbInw34KVZqL?=
 =?us-ascii?Q?Pc5pMozihfXM6S9E3hh5eJts9zuyObSZEmVbna/kKssctoc/xw0K5W0WKClp?=
 =?us-ascii?Q?9xRh94Q2vzfxOljfKDriBjbJwaxm304BXjMcsyyDqZ1oEw4gSJwS5UCirUM5?=
 =?us-ascii?Q?8J3LatcMgefnzYv2M+3pL78bL5NnhAc66kzTIPOqLzSONLDqSWGSIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af3bead-71a6-4be2-6eba-08da0e31e447
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:34:27.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMUPi9wrqBS8YA2jqu94npoQCDIxexYfyVFDgRWvxkrAHhX6+mxO3cT5rmlZWVbN35fwQXN9brU83P6pHxpoWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8020
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram would like to recall the message, "[PATCHv3] mac80211:=
 disable BSS color collision detection in case of no free colors".=

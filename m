Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0734315BB34
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgBMJJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:09:11 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:14154 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729515AbgBMJJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:09:10 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D90biG029210;
        Thu, 13 Feb 2020 02:07:26 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u4wktxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 02:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXhHZOpf7IizZAveumNpWRq8GNvP1fvYSXSc6Zit6ULV+y6/M/mIuwbOkmw0uzNeNZKlE9T9vK7VrKxfxPVSa3Alhbg+OtVKZ+NtgR4qp1H9FwiDwa/JhW+u4oT6G84znMPV4PxIJoPeW5c1Pbq+H/T8Qk5d6cpiMjKa2QJe5vWu3u/Vl7oTZzkIs46HheS5CNo0hKQrEncE0YleHWDR3Im8mQW6yifAdRGGN9xcJwgV36IwKnyXEIMdjVrM9I4W/ArdPdr+gQDkX5sU4PROQWGWn3FG7Pzlsm+Jx30MEcGTehFo39YeiTnc9j7KlDw0DBdLmgkFzSfnJm2vn8vxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmdEi9fY70jCPVO9CrM3HPQhBtUXBDgQQVBsK9xyZf0=;
 b=ANDzu3udZ9jLLu94J+d7NlZGpB/98pGbSSiM3e6/pIc6Z5dQlcTE5kDyqO4JZRwDT3c3veibpzq4fleIUC3XjKJyJOyRodWXo2rL/LoIq8dM1f+ltJtku2henFDK1Wp7JE91LV+4MP8V1CxuwxeiL5dHs2IaE/8YATfmCwlAs9I4BroLp2PvqG/S5CJ0+VXOtSZeUZRtmeFLvMjoQr1G1SGyHrVnKWgHIRavvaSUhBGMlqKfRYOW/2oFIWtP0UdNIP7jz1cnuSFVAKPsy42a0YAGy5oQCS4UfiSXWRZ7GHPqKN1IK1ukJ0rf5w5IrHbIZvMYxvxiupv54IYgY7ILKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmdEi9fY70jCPVO9CrM3HPQhBtUXBDgQQVBsK9xyZf0=;
 b=imqBg7b+yIfClvpaxZ/sYyBqra7FVUkBnPu59vdQVvNTJjxQmHRgA4Vcg1fwyQuwHGVG64CkvLfFyb7ywF2emccSDsAQFWxWefnq+sLsaLSihIAEkSFIVqisefj8HM5sNu2zdwa1rAn2JKpqpgdv6SFIL6sALUwpI+Aj/i6bD5U=
Received: from BY5PR05MB6963.namprd05.prod.outlook.com (10.255.89.15) by
 BY5PR05MB7172.namprd05.prod.outlook.com (52.132.255.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.19; Thu, 13 Feb 2020 09:07:24 +0000
Received: from BY5PR05MB6963.namprd05.prod.outlook.com
 ([fe80::b9f2:357a:1d35:865c]) by BY5PR05MB6963.namprd05.prod.outlook.com
 ([fe80::b9f2:357a:1d35:865c%4]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 09:07:23 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5550.namprd05.prod.outlook.com (52.135.110.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 09:07:04 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 09:07:04 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0273.eurprd05.prod.outlook.com (2603:10a6:3:fc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 09:07:03 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 0/2] cfg80211: minor updates for WPA3 OWE support
Thread-Topic: [RFC PATCH 0/2] cfg80211: minor updates for WPA3 OWE support
Thread-Index: AQHV4kz1fx8uggeRU0arkSJPtpx5Gw==
Date:   Thu, 13 Feb 2020 09:07:04 +0000
Message-ID: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0273.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::25) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea28e4c6-95f6-4a18-29cf-08d7b064180a
x-ms-traffictypediagnostic: SN6PR05MB5550:|BY5PR05MB7172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5550922CE7FF98EA97EF3B49A31A0@SN6PR05MB5550.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 9:07:22 AM
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(103116003)(478600001)(6916009)(316002)(66946007)(66476007)(66556008)(64756008)(66446008)(956004)(2616005)(6486002)(52116002)(54906003)(7696005)(15650500001)(2906002)(107886003)(4326008)(36756003)(8936002)(81166006)(81156014)(8676002)(71200400001)(4744005)(86362001)(5660300002)(1076003)(16526019)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR05MB7172;H:BY5PR05MB6963.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1mgMNW3kP6XPrWhk2pcPRn26vrXxe4GfHXUjdXgZQjH3IhBaXcKKcZvLgt2UkzCX9JlTsP3DvdChZF4xSW2Fbz4WIDJ/pGV0dpJSeKusTQC+gvokxytCbd+4TKI2K/q7K63AV3EPCdSQvENJ1pPNo//WSv1KjQUmUUMZE4HkEhnnQNQpDY4l8K5SjTxq/AZW1QJn0K/+4E8/bcoeABXSg3CjaVBOfdsBcRVBIAvl13NM3dGGEoGRPDLY5nGeLzOltOSdV0TdetVlgs+BSasl1wKR6bqhNtEUViCHYf14Iv3FhfNnssmdWw/eNsuYbunnzV4/271C5z8gkbrlBiwqSpJFcV/w/StPX16KDow0Zg8R04pR2SFA+FnSXzJ7JhTRKfVrQOG7sYpX/cKKTashycju5yNqOCsc1LGQJ7a6faNi4l6q0opbJkrkBOQzHsM
x-ms-exchange-antispam-messagedata: TBbgsY6rhKpgy1RDjzrGIhZBWkfydl6yy1GlLBKwEM7yckh03Og+VWHQDLOhyVpfj09gBrd1bMfpent7k0Ou0vjqVDRZwm8jrJzbHiIb/TT5NHanJU2Y1XOOf2ViBFC2Cgmh+/mlImLlCI4MbXdtnQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea28e4c6-95f6-4a18-29cf-08d7b064180a
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BRAYe3W73kEMeo6GANgDoLnig/BC/+I88F3ZuLI/WKoTFIyIU7UvnjBt8SEYw5OS7mBKIbswPeap052NLMTNFT/VvYDv6CqpSwPzqTlZ53rsdV2rdhRenJbQ6ZUIa9a543LC/J+iYZsPYbb1q4I1hiL5op511zr8bcSblJPDMLhbGs/eZBczvC+ytzBB37TuV/HfovHO0jJeDfqBokBykvbaMnv3NLpcDKjw0vKM18=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:07:23.9974
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=597 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130072
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes and all,

This patch series suggests a couple of minor changes related to WPA3 OWE.
One patch adds define for OWE AKM suite. Another patch disables strict
validation for UPDATE_OWE command.

When strict validation is enabled, kernel rejects appropriate hostapd
command with 'unsupported attribute' error message. This message is
related to status attribute NL80211_ATTR_STATUS_CODE, which is added
to nl80211 messsage using nla_put_u16.

Let me know if disabling strict validation is now frowned upon and
there is a more appropriate way to make existing hostapd command to
work properly.

Regards,
Sergey

Sergey Matyukevich (2):
  cfg80211: skip strict validation for UDPATE_OWE command
  ieee80211: add WPA3 OWE AKM suite selector

 include/linux/ieee80211.h | 1 +
 net/wireless/nl80211.c    | 1 +
 2 files changed, 2 insertions(+)

--=20
2.11.0


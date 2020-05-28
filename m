Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702BF1E647A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgE1Otr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:49:47 -0400
Received: from p-impout010aa.msg.pkvw.co.charter.net ([47.43.26.141]:47484
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728539AbgE1Otr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:49:47 -0400
Received: from localhost ([97.96.18.55])
        by cmsmtp with ESMTPA
        id eJqqjJE4EOQ8heJqrjWzmS; Thu, 28 May 2020 14:49:45 +0000
X-Authority-Analysis: v=2.3 cv=SrXuF8G0 c=1 sm=1 tr=0
 a=gnb2rATmHlbHhomeAxXZdQ==:117 a=gnb2rATmHlbHhomeAxXZdQ==:17
 a=IkcTkHD0fZMA:10 a=o-53GSTNTxPpq0pbfBgA:9 a=QEXdDO2ut3YA:10
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: iwlwifi: 8265: unexpected LLC packets TX'ed in monitor mode
From:   "Marco" <marco@tampabay.rr.com>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
Date:   Thu, 28 May 2020 10:26:04 -0400
Message-Id: <C32FKI01HMGA.U0TCA9AIO8BX@b1>
In-Reply-To: <ca2b26a87d49284a07b24c71046993814c4fe821.camel@sipsolutions.net>
X-CMAE-Envelope: MS4wfAOq67BEj59AZO74DpW9m/MifcsIuyVHgMfbLrRjLBJC34PnTKOkITiACRxMGt4nko6fHHE9FCp3xXAyV1uJUPvjy/DycxTCFoFC3mh4ii2i9BOkfpQJ
 //XQYg4ONCvX+FG6SvQKUvs9GviBrYgUiW4tmVdemzOyV0sPVKQqC0OGGMiAD2Jo5n5nWTCSdy9yCdKD60L3Vd7TC3nM2v6iJDQ=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon May 25, 2020 at 7:23 AM EDT, Johannes Berg wrote:
> On Wed, 2020-05-13 at 13:48 -0400, Marco Fonseca wrote:
> > Hello,
> >=20
> > While in monitor mode, the 8265 will periodically transmit gratuitous
> > LLC packets.  In this mode, I would expect the wifi chipset to not
> > transmit any packets at all (unless packet injection is being used).
> >=20
> > This behavior can be observed by a second wifi device in monitor mode.
> > A display filter on wireshark/tshark of 'llc' makes these easy to spot.
> >=20
> > It seems these packets only get produced in presence of a few APs
> > and/or STAs but I'm not sure of the exact cause.  I don't see the LLC
> > packets on very quiet channels.
>
> I think these are somehow related to calibrations in the device.
>
> johannes

Are you perhaps implying that I can alter calibration settings to fix
this problem?  If you have any pointers to this it would be
appreciative.

Regardless though, I would still expect the default behavior to not
emit packets when in monitor mode, unless the user directs it to;
similar to what I've seen from other wifi chipsets.

Marco

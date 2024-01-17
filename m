Return-Path: <linux-wireless+bounces-2077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FC830092
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E636A1C23A38
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3BBA27;
	Wed, 17 Jan 2024 07:34:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAEBA4B
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476862; cv=none; b=GIP6a0FTsk898A4UNxQME7i6VvkcbbqB9CrEIzL79Xk9eEAOwtwuq32gcK8RYymASHBqi+APdpXfafg1rbMNxxG9W6TKVrbdruDyn8q5XUeBtwdf6RfrJs6s1/HzkZV2h1bveB9MVpdohJk07jTuYm6jlYU5tLcvIWWPiHoclxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476862; c=relaxed/simple;
	bh=VomAmoHIT1liQZzrN8ZStht6+mCxWW+0I+3bHwP5MAk=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Sent-From:X-URL:
	 X-Accept-Language:X-Accept-Content-Type:User-Agent:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-SA-Exim-Scanned:
	 X-PTX-Original-Recipient; b=lRYeDOAOVhINTObLi7uTh6+3i00j4/xIXzhASLTKBtjlMvfgB8SolG1e742GLRXvRr47DXIQrG1PEs5RdVy0LcAJXlNVJOZiYybWpMSKXHCTig63tm1Mlql6eWyg0EVvNVdKprxxdY4CKGyfQrRnSZb7M9AO7vZ8ojXGd8+BWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rQ0R9-0004fE-C0; Wed, 17 Jan 2024 08:34:11 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rQ0R7-000PlU-0I; Wed, 17 Jan 2024 08:34:09 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rQ0R6-000LvH-Tw; Wed, 17 Jan 2024 08:34:08 +0100
Date: Wed, 17 Jan 2024 08:34:08 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viacheslav <adeep@lexina.in>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Jernej =?iso-8859-15?Q?=A6krabec?= <jernej.skrabec@gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
Message-ID: <20240117073408.GG4700@pengutronix.de>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com>
 <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com>
 <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com>
 <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
 <fe8cd87ad7dd43ecb41613530386dff4@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe8cd87ad7dd43ecb41613530386dff4@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Wed, Jan 17, 2024 at 12:35:42AM +0000, Ping-Ke Shih wrote:
> + Sascha for question 3)
> 
> (no other comments for now)
> 
> > -----Original Message-----
> > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Sent: Wednesday, January 17, 2024 6:07 AM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Viacheslav <adeep@lexina.in>
> > Cc: linux-wireless@vger.kernel.org; Jernej Škrabec <jernej.skrabec@gmail.com>
> > Subject: Re: rtw88: rtl8822cs AP mode not working
> > 
> > Hi Ping-Ke and Viacheslav,
> > 
> > On Mon, Jan 15, 2024 at 3:17 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
> > [...]
> > > > > I don't have this kind of wifi cards, could you help to check if AP mode
> > > > > works in your side?
> > > > I'll check that in the next few days.
> > AP mode is also not working for me, I get the same problem as
> > Viacheslav reported.
> > 
> > > > Also I'm wondering where code enables beacons (is it
> > > > rtw_core_enable_beacon() or is there another relevant function?).
> > > > Knowing that would be helpful to analyze this further.
> > >
> > > The main function to get and set beacon template to firmware is
> > > rtw_fw_download_rsvd_page(). The basic concept is to put beacon frame via
> > > qsel=BCN to a special TX FIFO area called "reserve page", and then
> > > hardware/firmware will send beacon in interval of 100ms.
> > Thanks for the explanation - that helped me find a better starting point!
> > 
> > I didn't have much time in the past few days, but I have some findings
> > and questions:
> > 1) I found the following comment/code in the downstream driver [0]:
> > /*
> >  * Disable Hw protection for a time which revserd for Hw sending beacon.
> >  * Fix download reserved page packet fail that access collision with
> > the protection time.
> >  */
> > val8 = rtw_read8(adapter, REG_BCN_CTRL_8822C);
> > restore[1] = val8;
> > val8 &= ~BIT_EN_BCN_FUNCTION_8822C;
> > val8 |= BIT_DIS_TSF_UDT_8822C;
> > rtw_write8(adapter, REG_BCN_CTRL_8822C, val8);
> > 
> > This is not part of the upstream rtw88 driver, so I made a patch and
> > attached it.
> > Unfortunately it doesn't fix the problem.
> > 
> > 2) PCI is the only HCI which does not need the checksum in the
> > pkt_Info (USB and SDIO need the checksum).
> > The checksum is added by rtw_tx_fill_txdesc_checksum() which is only
> > called in usb.c and sdio.c.
> > My understanding is that for reserved pages we can have more than one
> > pkt_info in the buffer (my starting point for this thought is
> > rtw_fill_rsvd_page_desc() from fw.c).
> > In usb.c and sdio.c we're only calculating the checksum for the very
> > first pkt_info, not for any subsequent ones (I didn't even know that
> > it's possible to have more than one pkt_Info outside of RX and TX
> > aggregation).
> > However, it seems that the downstream code calculates the TX checksum
> > for *all* pkt_info in the buffer, see [1]
> > This code is missing from rtw88 at the moment. Since I didn't have
> > time I did not try to implement this yet.
> > 
> > 3) Has anybody tried AP mode with rtw88 on a (supported) USB chipset?
> > If my thought (from #2) is correct then AP mode would show the same
> > problems there.

I haven't tried AP mode with the rtw88 driver. Shame on me, but I didn't
want to open that can of worms at that time.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


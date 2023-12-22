Return-Path: <linux-wireless+bounces-1196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962181C383
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 04:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B07286268
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 03:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54317F4;
	Fri, 22 Dec 2023 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY8IH9rm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA517D3
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 03:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4496DC433C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703215961;
	bh=VzUmGYXnlX4K2+67rVxrZqkmwL1w0hKwOQcvHx2RGQg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=EY8IH9rmBuyJAcxeEywuyWd2x9SXsUVsSg7meIolz7r7DARLbK3KZmo4/gEemQ292
	 ywAoqTGSbIjws/qLvxBGFR9JjedqDuygMplcbB6H5tfeaKTIUEHlCy2HKamp3Ml30Z
	 3ZYa1sfjlvF0ArVcOd9OQHaxnb8EwN1AGIkF4g5d6AMYGkkvNI4itSbF0gRTjyywde
	 Sl4OdHfIYzyKLcB0c1PpF89fRqtYNLKqlFBviba36w8s51ZZFOyGnXzdx2FfTjcrgu
	 MK6BCoUYGyneAgfbpzHf31go6/jdd18ape9QmL6qihu38qbIgJAkqwAiWUd2QQd4fo
	 mQ2wEt+RWy3rg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so1054339b6e.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 19:32:41 -0800 (PST)
X-Gm-Message-State: AOJu0YyQDAbwryeO83Mhf2J4j32r7XzLGkyg5MzNykHqpww33zJk2rMr
	hhQjLYYCBIvy4eM/GxDJGvPXm2N7NOmU4zvfslE=
X-Google-Smtp-Source: AGHT+IGITXZwz+rRhCdnZx1YCreGepZb864ZKGSj5n5Fe8f4KFIho/XRs2nNzQaUBM4EcKUW7W1H2MFPJD0FoEnZxfY=
X-Received: by 2002:a05:6808:2f09:b0:3ba:e0c:398f with SMTP id
 gu9-20020a0568082f0900b003ba0e0c398fmr939540oib.104.1703215960556; Thu, 21
 Dec 2023 19:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
 <a0480e18-7b67-4e16-983e-c8f888c97261@16depo.xyz> <CAGb2v65V==YE=NLYyE=2ApN04jPeuFFc9d6bfTaQYBUsXoFWsQ@mail.gmail.com>
 <21b0fc55-6b5d-404b-88d1-3ad2b7acbbcd@16depo.xyz>
In-Reply-To: <21b0fc55-6b5d-404b-88d1-3ad2b7acbbcd@16depo.xyz>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 22 Dec 2023 11:32:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RqgpA8RMyTKSq3FrDQMQyKqOi5ycQ8Wu81PwiRyi0JA@mail.gmail.com>
Message-ID: <CAGb2v65RqgpA8RMyTKSq3FrDQMQyKqOi5ycQ8Wu81PwiRyi0JA@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Armenia (AM)
To: Kirill Matvienko <me@16depo.xyz>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBEZWMgMTQsIDIwMjMgYXQgMTE6NDDigK9QTSBLaXJpbGwgTWF0dmllbmtvIDxtZUAx
NmRlcG8ueHl6PiB3cm90ZToNCj4NCj4gSSBoYXZlIG5vIGV2aWRlbmNlIHRvIHdoeSBiYW5kd2lk
dGggcmVzdHJpY3Rpb24gZXhpc3QgaW4gdGhlIGZpcnN0DQo+IHBsYWNlLCBhbmQgbXkgbWFpbiBj
b25jZXJuIGluIG5vdCBwb3dlciBvciBiYW5kd2lkdGgsIGJ1dCBudW1iZXIgb2YNCj4gY2hhbm5l
bHMuIE5vdyBtb3N0IHdpcmVsZXNzIHZlbmRvcnMgdXNlIG9ubHkgVU5JSS0xIGFuZCAobGVzcyBv
ZnRlbikNCj4gVU5JSS0yIGZvciBBTSByZWd1bGF0b3J5IGRvbWFpbiwgYnV0IHRoaXMgZGVjaXNp
b24gZnJvbSByZWd1bGF0b3JzIHdpbGwNCj4gYWxsb3cgdG8gdXNlIFVOSUktMiBleHRlbmRlZCBh
bmQgVU5JSS0zLg0KPiBUaGUgZG9jdW1lbnQgdGhhdCBiZWluZyBhbWVuZGVkIGlzIE4tMTY5DQo+
IChodHRwczovL3d3dy5hcmxpcy5hbS9kb2N1bWVudHZpZXcuYXNweD9kb2NpZD03Njg3NyksIGFu
ZCB0aGVyZSBpcyBvbmx5DQo+IHRoaXMgcGFzc2FnZSBhYm91dCA1R0h6Og0KPg0KPiA1MTUwIC0g
NTI1MCDVhNWA1oEsIDU3MjUgLSA1ODc1INWE1YDWgSDVvNWh1aTVq9W41bDVodWz1aHVrdWh1a/V
odW21bjWgtWp1bXVuNaC1bbVttWl1oDVqyDVt9Wl1oDVv9Wl1oDVuNaC1bQNCj4g1aHVt9Wt1aHV
v9W41bIsINW01avVttW51ocgMTAwINW01Y7VvyDVsNWm1bjWgNW41oLVqdW11aHVtNWiLCDVrNW4
1a/VodWsINaB1aHVttaB1aXWgNWrINW91aHWgNaE1aHVvtW41oDVuNaC1bTVttWl1oDVqw0KPiDW
hdWj1b/VodWj1bjWgNWu1bTVodW2INWw1aHVtNWh1oAgKNW01avVodW11bYg1bfVpdW21oTVpdaA
1asg1bbVpdaA1b3VuNaC1bQsINWr1bbVudW61aXVvSDVttWh1ocg1oXVpNWh1bbVodW+1aXWgNW4
1oLVtGAg1aXWgNWv1oDVqw0KPiDVtNWh1a/VpdaA1ofVuNaC1bXVqdWr1oEgMzAwMCDVtNWl1b/W
gNWr1oEg1aLVodaA1bHWgCDVqdW81avVudaE1asg1arVodW01aHVttWh1a8pLCA1MjUwIC0gNTM1
MCDVhNWA1oEsIDU0NzAgLQ0KPiA1NzI1INWE1YDWgSDVvNWh1aTVq9W41bDVodWz1aHVrdWh1a/V
odW21bjWgtWp1bXVuNaC1bbVttWl1oDVqyDVt9Wl1oDVv9Wl1oDVuNaC1bQg1aHVt9Wt1aHVv9W4
1bIsINW01avVttW51ocxMDAg1bTVjtW/DQo+INWw1abVuNaA1bjWgtWp1bXVodW01aIsINWs1bjV
r9Wh1awg1oHVodW21oHVpdaA1asg1b3VodaA1oTVodW+1bjWgNW41oLVtNW21aXWgNWrINaF1aPV
v9Wh1aPVuNaA1a7VtNWh1bYg1bDVodW01aHWgA0KPiAo1oXVpNWh1bbVodW+1aXWgNW41oLVtGAg
1aXWgNWv1oDVqyDVtNWh1a/VpdaA1ofVuNaC1bXVqdWr1oEgMzAwMCDVtNWl1b/WgNWr1oEg1aLV
odaA1bHWgCDVqdW81avVudaE1asg1arVodW01aHVttWh1a8pLA0KPg0KPiB3aGljaCB0cmFuc2xh
dGVkIGFzOg0KPg0KPiBPcGVyYXRpbmcgaW4gdGhlIHJhZGlvIGZyZXF1ZW5jeSBiYW5kcyA1MTUw
IC0gNTI1MCBNSHosIDU3MjUgLSA1ODc1IE1IeiwNCj4gZm9yIHRoZSB1c2Ugb2YgbG9jYWwgYXJl
YSBuZXR3b3JrIGVxdWlwbWVudCB3aXRoIGEgcG93ZXIgb2YgdXAgdG8gMTAwIG1XDQo+IChvbmx5
IGluc2lkZSBidWlsZGluZ3MsIGFzIHdlbGwgYXMgaW4gYWlyY3JhZnQgd2hlbiBmbHlpbmcgYWJv
dmUgMzAwMA0KPiBtZXRlcnMgYWJvdmUgdGhlIGVhcnRoJ3Mgc3VyZmFjZSksIDUyNTAgLSA1MzUw
IE1IeiwgNTQ3MCAtIDU3MjUgTUh6IGZvcg0KPiB0aGUgdXNlIG9mIGxvY2FsIG5ldHdvcmsgZXF1
aXBtZW50IG9wZXJhdGluZyBpbiByYWRpbyBmcmVxdWVuY3kgYmFuZHMNCj4gd2l0aCBhIHBvd2Vy
IG9mIHVwIHRvIDEwMCBtVyAoaW4gYWlycGxhbmVzIGR1cmluZyBmbGlnaHQgYWJvdmUgMzAwMA0K
PiBtZXRlcnMgYWJvdmUgdGhlIGVhcnRoJ3Mgc3VyZmFjZSk7DQo+DQo+IEFueXdheSwgaWYgeW91
IHRoaW5rIHRoYXQgd2UgY2FuJ3QgdXNlIHdpZGVyIGNoYW5uZWxzLCBwbGVhc2UsIGNoYW5nZQ0K
PiBvbmx5IGZyZXF1ZW5jaWVzIGFuZCBwb3dlci4NCg0KQ2FuIHlvdSBzZW5kIGEgbmV3IHZlcnNp
b24gY2hhbmdpbmcgbm90IHRoZSBiYW5kd2lkdGggYnV0IGV2ZXJ5dGhpbmcgZWxzZT8NClRoYXQg
d291bGQgcHJvdmlkZSBhIGJldHRlciB0cmFpbC4NCg0KUGxlYXNlIGFsc28gaW5jbHVkZWQgdGhl
IHRyYW5zbGF0ZWQgdGV4dCBpbiB0aGUgY29tbWl0IGxvZy4gU29tZXRpbWVzDQpVUkxzIHdpbGwg
ZGlzYXBwZWFyIGR1ZSB0byBvbmUgcmVhc29uIG9yIGFub3RoZXIuDQoNCg0KVGhhbmtzDQpDaGVu
WXUNCg0KPiBPbiAxNC4xMi4yMDIzIDE4OjAyLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+ID4gT24g
VGh1LCBEZWMgMTQsIDIwMjMgYXQgNzowNOKAr1BNIEtpcmlsbCBNYXR2aWVua28gPG1lQDE2ZGVw
by54eXo+IHdyb3RlOg0KPiA+Pg0KPiA+PiBTb3VyY2U6aHR0cHM6Ly93d3cuYXJsaXMuYW0vRG9j
dW1lbnRWaWV3LmFzcHg/RG9jSUQ9MTgxODI5DQo+ID4NCj4gPiBUaGlzIG9ubHkganVzdGlmaWVz
IHRoZSBwb3dlciBsaW1pdCBjaGFuZ2UuIFdoYXQgYWJvdXQgdGhlDQo+ID4gbWF4aW11bSBiYW5k
d2lkdGg/DQo+ID4NCj4gPg0KPiA+IENoZW5ZdQ0KPiA+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEtp
cmlsbCBNYXR2aWVua28gPG1lQDE2ZGVwby54eXo+DQo+ID4+DQo+ID4+IC0tLQ0KPiA+PiAgICBk
Yi50eHQgfCA0ICsrLS0NCj4gPj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RiLnR4dCBiL2RiLnR4dA0K
PiA+PiBpbmRleCBmZGMyYzEzLi4wNzA4MDM5IDEwMDY0NA0KPiA+PiAtLS0gYS9kYi50eHQNCj4g
Pj4gKysrIGIvZGIudHh0DQo+ID4+IEBAIC04MCw4ICs4MCw4IEBAIGNvdW50cnkgQUw6IERGUy1F
VFNJDQo+ID4+DQo+ID4+ICAgIGNvdW50cnkgQU06IERGUy1FVFNJDQo+ID4+ICAgICAgICAoMjQw
MiAtIDI0ODIgQCA0MCksICgyMCkNCj4gPj4gLSAgICAoNTE3MCAtIDUyNTAgQCAyMCksICgxOCkN
Cj4gPj4gLSAgICAoNTI1MCAtIDUzMzAgQCAyMCksICgxOCksIERGUw0KPiA+PiArICAgICg1MTUw
IC0gNTM1MCBAIDgwKSwgKDEwMG1XKQ0KPiA+PiArICAgICg1NDcwIC0gNTg3NSBAIDgwKSwgKDEw
MG1XKSwgTk8tT1VURE9PUixERlMNCj4gPj4NCj4gPj4gICAgY291bnRyeSBBTjogREZTLUVUU0kN
Cj4gPj4gICAgICAgICgyNDAyIC0gMjQ4MiBAIDQwKSwgKDIwKQ0KPiA+PiAtLQ0KPiA+PiAyLjM0
LjENCj4gPj4NCg==


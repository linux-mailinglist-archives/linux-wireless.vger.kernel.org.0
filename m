Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88AA4A9ABA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiBDOLG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 09:11:06 -0500
Received: from bluehome.net ([96.66.250.149]:44556 "EHLO bluehome.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbiBDOLG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 09:11:06 -0500
Received: from valencia (valencia.lan [10.0.0.17])
        by bluehome.net (Postfix) with ESMTPSA id 9FC214B40B91;
        Fri,  4 Feb 2022 06:11:05 -0800 (PST)
Date:   Fri, 4 Feb 2022 06:11:04 -0800
From:   Jason Self <jason@bluehome.net>
To:     johannes.berg@intel.com, linux-wireless@vger.kernel.org
Subject: Fw: Regression/boot failure on 5.16.3
Message-ID: <20220204061104.5851831a@valencia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/O_XmO2iBIWJqYgdNKyHe=CN"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/O_XmO2iBIWJqYgdNKyHe=CN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Forwarding as requested.

Begin forwarded message:

On Fri, 4 Feb 2022 08:00:17 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> Please cc: the authors of this commit, and the upstream wireless
> developers so they can help you out here as I think the same issue
> shows up in 5.17-rc2, right?
>=20
> thanks,
>=20
> greg k-h

Date: Thu, 3 Feb 2022 16:19:59 -0800
From: Jason Self <jason@bluehome.net>
To: stable@vger.kernel.org
Subject: Regression/boot failure on 5.16.3


The computer (amd64) fails to boot. The init was stuck at the
synchronization of the time through the network. This began between
5.16.2 (good) and 5.16.3 (bad.) This continues on 5.16.4 and 5.16.5.
Git bisect revealed the following. In this case the nonfree firmwre is
not present on the system. Blacklisting the iwflwifi module works as a
workaround for now.

6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1 is the first bad commit
commit 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Dec 10 11:12:42 2021 +0200

    iwlwifi: fix leaks/bad data after failed firmware load
   =20
    [ Upstream commit ab07506b0454bea606095951e19e72c282bfbb42 ]
   =20
    If firmware load fails after having loaded some parts of the
    firmware, e.g. the IML image, then this would leak. For the
    host command list we'd end up running into a WARN on the next
    attempt to load another firmware image.
   =20
    Fix this by calling iwl_dealloc_ucode() on failures, and make
    that also clear the data so we start fresh on the next round.
   =20
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
    Link:
    https://lore.kernel.org/r/iwlwifi.20211210110539.1f742f0eb58a.I1315f22f=
6aa632d94ae2069f85e1bca5e734dce0@changeid
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)




On Fri, 4 Feb 2022 09:48:24 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> [TLDR: I'm adding this regression to regzbot, the Linux kernel
> regression tracking bot; most text you find below is compiled from a
> few templates paragraphs some of you might have seen already.]
>=20
> Hi, this is your Linux kernel regression tracker speaking.
>=20
> Adding the regression mailing list to the list of recipients, as it
> should be in the loop for all regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>=20
> On 04.02.22 01:19, Jason Self wrote:
> > The computer (amd64) fails to boot. The init was stuck at the
> > synchronization of the time through the network. This began between
> > 5.16.2 (good) and 5.16.3 (bad.) This continues on 5.16.4 and 5.16.5.
> > Git bisect revealed the following. In this case the nonfree firmwre
> > is not present on the system. Blacklisting the iwflwifi module
> > works as a workaround for now.
> >=20
> > 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1 is the first bad commit
> > commit 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1
> > Author: Johannes Berg <johannes.berg@intel.com>
> > Date:   Fri Dec 10 11:12:42 2021 +0200 =20
>=20
> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
>=20
> #regzbot ^introduced 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1
> #regzbot title net: iwlwifi: system fails to boot since 5.16.3
> #regzbot ignore-activity
>=20
> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> to the report (the parent of this mail) using the kernel.org
> redirector, as explained in
> 'Documentation/process/submitting-patches.rst'. Regzbot then will
> automatically mark the regression as resolved once the fix lands in
> the appropriate tree. For more details about regzbot see footer.
>=20
> Sending this to everyone that got the initial report, to make all
> aware of the tracking. I also hope that messages like this motivate
> people to directly get at least the regression mailing list and
> ideally even regzbot involved when dealing with regressions, as
> messages like this wouldn't be needed then.
>=20
> Don't worry, I'll send further messages wrt to this regression just to
> the lists (with a tag in the subject so people can filter them away),
> as long as they are intended just for regzbot. With a bit of luck no
> such messages will be needed anyway.
>=20
> Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)
>=20
> P.S.: As a Linux kernel regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them.
> Unfortunately therefore I sometimes will get things wrong or miss
> something important. I hope that's not the case here; if you think it
> is, don't hesitate to tell me about it in a public reply, that's in
> everyone's interest.
>=20
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
>=20
>=20
> >     iwlwifi: fix leaks/bad data after failed firmware load
> >    =20
> >     [ Upstream commit ab07506b0454bea606095951e19e72c282bfbb42 ]
> >    =20
> >     If firmware load fails after having loaded some parts of the
> >     firmware, e.g. the IML image, then this would leak. For the
> >     host command list we'd end up running into a WARN on the next
> >     attempt to load another firmware image.
> >    =20
> >     Fix this by calling iwl_dealloc_ucode() on failures, and make
> >     that also clear the data so we start fresh on the next round.
> >    =20
> >     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> >     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> >     Link:
> >     https://lore.kernel.org/r/iwlwifi.20211210110539.1f742f0eb58a.I1315=
f22f6aa632d94ae2069f85e1bca5e734dce0@changeid
> >     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >=20
> >  drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 8 ++++++++
> >  1 file changed, 8 insertions(+) =20
>=20
> ---
> Additional information about regzbot:
>=20
> If you want to know more about regzbot, check out its web-interface,
> the getting start guide, and/or the references documentation:
>=20
> https://linux-regtracking.leemhuis.info/regzbot/
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>=20
> The last two documents will explain how you can interact with regzbot
> yourself if your want to.
>=20
> Hint for reporters: when reporting a regression it's in your interest
> to tell #regzbot about it in the report, as that will ensure the
> regression gets on the radar of regzbot and the regression tracker.
> That's in your interest, as they will make sure the report won't fall
> through the cracks unnoticed.
>=20
> Hint for developers: you normally don't need to care about regzbot
> once it's involved. Fix the issue as you normally would, just
> remember to include a 'Link:' tag to the report in the commit
> message, as explained in Documentation/process/submitting-patches.rst
> That aspect was recently was made more explicit in commit
> 1f57bd42b77c: https://git.kernel.org/linus/1f57bd42b77c
>=20

--Sig_/O_XmO2iBIWJqYgdNKyHe=CN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE9hGpCP+hZcaZWE7UnQ2zG1RaMZgFAmH9M/gACgkQnQ2zG1Ra
MZjr4g//XCLub1aASfPkhmYHXb+5z0LccxJdgv3pXF7/UaZ9zZ+aevgRwMOels2+
sAgr1EyvR3lvxC3K9myqRcy5QhB86sNUJf+iEeiz0NtbfdGPwYCUmbT7F1UY/AMk
IYmzIjNlWkmEQOj/2EPpE0S08JgoY7xUZS0NjOR7mjefxKYG/pM4Mq4yRIfcOrW4
EJTu5Fp0oxywtCNMmNRQQXvvPdBqLjpitDhGoR07OsEk99JZrmb4J+iQcTHhdzq8
PXqnEYFpzLfYJyWUM9IvMQ9hUCed0x/9uUfvbJpYauEibE45ZmXLCUix5lSNL/jn
g9eYtjuQRz1tqA8fYVI9jSBWrd0gKOHTTT12HdfAnmeJTtRIfOMW53Oyq0vWurfM
XZMtCy8gC2HXFDbmnlXPcXNpo6KYixsw7JhP0SqXYvH7/vGuPFf1FhnDKQmaAOK/
M8sg5CR0vNU/zheVFpQI6TNMkc4qmXIMiT05eqLCmselyqTDJ2TNvqiaIMPjhu1Z
wOmSvkZBxjbDkTwXVcpPyTTMY/My7KE4WKNyxdxqEdkwz1rOLNqCGDtqBGLV0PVA
hDl+srTDrcI9ndLi3eldYpLAo8kNR/Q2GhWLc/ZkC5REWy/ig+VVIYw/pyHlY6Ep
I7NF5mon+LDf7u7C247YRtN7HcUUVWlsTgBVJwHfhK7Bu4lfVoY=
=cUiZ
-----END PGP SIGNATURE-----

--Sig_/O_XmO2iBIWJqYgdNKyHe=CN--

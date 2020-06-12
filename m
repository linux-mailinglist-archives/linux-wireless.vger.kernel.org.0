Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593811F76CB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLKfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 06:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgFLKfJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 06:35:09 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654EF207D8;
        Fri, 12 Jun 2020 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591958108;
        bh=r3r/LlifhXssd71MGB+AGz0k2Z7U7mZc45nMA5vvgKY=;
        h=Date:From:To:Subject:From;
        b=iMBnMmoux0UsnSN+qp+LjkKMGblrRfo3Fd9UgSk1GRJlPtWSKGisWYNPpgTMNIZmb
         e2rUSRJOi383nF+M+ndL9wbGbjEVtXcY2Yc26DxQUU/gO2EHEbi377icqvqCH+HLqt
         vvk9rALw0evOY4e62PUCzYUZaPtE6UJez9l1QH0o=
Received: by pali.im (Postfix)
        id 28ED7582; Fri, 12 Jun 2020 12:35:06 +0200 (CEST)
Date:   Fri, 12 Jun 2020 12:35:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: mwifiex: Initialization of FW and net interface
Message-ID: <20200612103501.vhwo3skvzt2243gz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

I was looking at mwifiex code which initialize card firmware and linux
network interface and I think that there are some issues with this code
path.

There is a function mwifiex_sta_init_cmd() which basically doing two
different things:

 * initial card firmware initialization
 * configuration of interface parameters via card firmware

That function has following definition:

int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init);

'first_sta' and 'init' is FALSE when doing just configuration of
interface parameters (by cfg80211 callbacks).

'init' is TRUE when doing initial card firmware initialization and it is
called when mwifiex driver is doing setup of card. But this function is
called with 'init' set to TRUE multiple times when card driver was
configured to create multiple linux network interfaces. In this case
'first_sta' is TRUE only for the first call of this function.

And now the first suspicious thing is: Why mwifiex driver calls that
initial card firmware initialization multiple times when network
interfaces are created during driver setup, and not when they are
created later by "iw phy phyX interface add ..."?

Next, looking at code of that function mwifiex_sta_init_cmd() it looks
like that all commands send to firmware are "global" and affects all
existing mwifiex network interfaces. Why then it is needed to call this
function when creating a new interface? (E.g. second bssid for AP mode).

Also if it really affects all existing interfaces, it means that
creating a new interface changes configured cfg80211 parameters of all
existing interfaces to some default values.

This also affects power save settings which I described in previous email:
https://lore.kernel.org/linux-wireless/20200609111544.v7u5ort3yk4s7coy@pali/

And the last and the most suspicious thing in that mwifiex_sta_init_cmd
function is that some AP related code is executed only during initial
card firmware initialization and only if initial interface is AP mode
('init' = TRUE, 'first_sta' = TRUE, mode = 'AP').

Seems that driver behaves differently if interfaces are created by
standard 'iw phy phyX interface add ..." command (via cfg80211 layer)
and differently if interfaces are created automatically during driver
setup function.

Are there any reasons for these differences? And what to do with the
fact that most firmware commands which affects all interfaces and not
just one which is initializing?

These issues which I described makes it hard for me to understand what
is driver really doing and what should be correct behavior.

By the way, do you have documentation for firmware commands?

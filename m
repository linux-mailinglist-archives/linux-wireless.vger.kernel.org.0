Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31EA1F66A3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFKLaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 07:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgFKLaM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 07:30:12 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180D82078D;
        Thu, 11 Jun 2020 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591875012;
        bh=fkkqzxBFgHGAb88n0qp01YgTeaU1w9laNmqo4DGnoiY=;
        h=Date:From:To:Subject:From;
        b=FCZ24leKXFbhlMpb6YLeI0ORR0vcsIspHztUhT8pCHi7EzYlvtqqrboYvOwxl+rZ7
         tXXqwmRkGa8hNGxtk+1Bnjj7X/xIsD/Uor3sPE/CKRbbmM/F/mrjsbRE1xIcCnwIa6
         tnA/D6lLQTDFXrSemC/FtHbaui5IImWpoD+wkrk4=
Received: by pali.im (Postfix)
        id 171F6851; Thu, 11 Jun 2020 13:30:10 +0200 (CEST)
Date:   Thu, 11 Jun 2020 13:30:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: mwifiex: Maximal number of AP interfaces
Message-ID: <20200611113009.v7cpybecc55vtni2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

mwifiex kernel driver has currently hardcoded maximal number of AP
interfaces to 3. It is defined by MWIFIEX_MAX_UAP_NUM constant and
'.max' member in 'mwifiex_ap_sta_limits' structure.

I tried to increase this limit and figured out that SD8997 card can
create four independent BSSIDs in AP mode. Not only 3. Scanning for wifi
networks on another device proved that SD8997 was really broadcasting 4
SSIDs.

When I tried to create fifth AP interface/SSID then mwifiex received
error "mwifiex_cmd_timeout_func: Timeout cmd id = 0x4d, act = 0x1" and
then card firmware crashed. SDIO card was then unregistered from bus.

I would like to increase maximal number of AP interface to 4 as it is
supported by SD8997 card. But it cannot be done easily as for other
cards managed by mwifiex driver which do not support more then 3 ap
interfaces, it can cause problems...

Looks like that maximal number of AP interfaces is firmware dependent
number. Do you know if it is possible to retrieve this maximal count
from card firmware via some special command?

Or do you know how to determinate maximal number of AP interfaces?

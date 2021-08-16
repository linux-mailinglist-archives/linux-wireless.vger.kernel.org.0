Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965E3EDA54
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhHPP7D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 11:59:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53749 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhHPP66 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 11:58:58 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 02FD5CECC8;
        Mon, 16 Aug 2021 17:58:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3 2/2] btbcm: add patch ram for bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210812165218.2508258-3-angus@akkea.ca>
Date:   Mon, 16 Aug 2021 17:58:23 +0200
Cc:     kernel@puri.sm, Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7539515D-AD91-4C40-AD18-44AB78EF4911@holtmann.org>
References: <20210812165218.2508258-1-angus@akkea.ca>
 <20210812165218.2508258-3-angus@akkea.ca>
To:     Angus Ainslie <angus@akkea.ca>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Angus,

> Bluetooth on the BCM43752 needs a patchram file to function correctly.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


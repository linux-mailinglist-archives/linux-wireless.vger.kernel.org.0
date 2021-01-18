Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CB2FA6CA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405480AbhARQzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 11:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405692AbhARQzN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:55:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8467222BB;
        Mon, 18 Jan 2021 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610988871;
        bh=ih190QYQKNN/j4+m3g3E21lwSCUP5xLzmIxPbjnJ+gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mq6tJv5vy31Tz6lmcZduOJ0k6rZIOxINZBEhoREolQkFVLAO8ejpe7Wk1cto1glsQ
         Mj8U3WsdjeyUKwrOgM9PgPqo8Aj+v+Xq8H+uIqWrYIEzUIKMbunnqAlM5/tlqdli2s
         zHo7iYVme3Wn54EhtWD2MyFgqZZ7hjPEn3Ayr28hiYk3HHRYXX/B3rFw4+wF20uI1E
         NQeA1QUfhnN10WmqMVdRIkDB4BDjLC96nBLa5IQszElz0qSzUl5/IuU1TvzDCJcqTI
         XJH4ScACqbKA2HxDjQeLawpCLwxr7GPKW/z+jNDmi7lig5+uv86YdLOMaBs6HuXl/X
         BjFnlmrGQPldA==
Date:   Mon, 18 Jan 2021 08:54:29 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        matthias_berndt@gmx.de, mozlima@gmail.com
Subject: Re: [PATCH wireless-drivers] mt7601u: fix kernel crash unplugging
 the device
Message-ID: <20210118085429.3495ee7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
References: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 17 Jan 2021 22:46:01 +0100 Lorenzo Bianconi wrote:
> Fix the following kernel crash unplugging the usb dongle
> 
> [...]
>
> Fixes: 23377c200b2eb ("mt7601u: fix possible memory leak when the device is disconnected")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

A few words of explanation beyond the stack trace without line info
would perhaps make the review quicker..

Acked-by: Jakub Kicinski <kubakici@wp.pl>

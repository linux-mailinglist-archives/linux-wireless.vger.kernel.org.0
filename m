Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934D2C4812
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKYTNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 14:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgKYTNH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 14:13:07 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF932204EF;
        Wed, 25 Nov 2020 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606331586;
        bh=hPsrYkdK0RL8/DPLg8udPJm58J/2DfMMVKBXCJDcKEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iW5Kt3/hTtlLbEoKd7KhQmyJZQ7Hd1p7oy+IgaEz2wDwHYGUaeZBVZAxBg+Uh13CD
         t6bU1I4ed2FCtVRtPCwbPeyNMSSeQNhoOEsuYWW4RxyKKZ/5RqSlhVxHsURoPsQG4J
         OaS2QFDFjMPmsjJDkDYh/NpePvkdLxE2wU9QVa0Q=
Date:   Wed, 25 Nov 2020 20:13:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian O'Keefe <bokeefe@alum.wpi.edu>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 1/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to
 common include file
Message-ID: <X76svnTHv34FJaHI@kroah.com>
References: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
 <a646a587-25ae-2395-a169-3742ba7f9723@alum.wpi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a646a587-25ae-2395-a169-3742ba7f9723@alum.wpi.edu>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 25, 2020 at 01:33:00PM -0500, Brian O'Keefe wrote:
> Macro names were derived from the Windows driver, as that was the best
> available source.

Why move these?  What does this help with?


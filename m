Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19951BB914
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD1Iqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD1Iqp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:46:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2AED206B9;
        Tue, 28 Apr 2020 08:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588063605;
        bh=FR6uldN0wEhhRMSQOfpDGFsE9p0TXsHzHOUWriICLp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvgEzo+C7Zibhc3MQRMUsjn5RyABa1c0Pxs0Bs9dr11/UbFo4UVkw6hMiDyQzVckV
         MwzildbvXNch8K2t8HSGfwTDP3wHum+5I3BmzxKSVa38SR63+jOo5WqnM4h+jVIsbO
         0ZyDFlqKZw0pItV//UK8J4RvOr2MQy26sJX3ooQA=
Date:   Tue, 28 Apr 2020 10:46:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        Johannes Berg <johannes.berg@intel.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 2/2] staging: wilc1000: adjust for management frame
 register API changes
Message-ID: <20200428084642.GD996383@kroah.com>
References: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
 <20200428101400.bac7e94c2bf8.I6a2287b9f68f35aff5f6de409c5ffa388de760e2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428101400.bac7e94c2bf8.I6a2287b9f68f35aff5f6de409c5ffa388de760e2@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 10:14:03AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Adjust to the API changes in cfg80211 for management frame registration.
> 
> Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

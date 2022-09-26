Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E845E9EAF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiIZKJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiIZKJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 06:09:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E146D8F
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 03:09:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so5795723plo.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oPLWL8Hh6dyljVbGJTzdQznEc5dQ4dVutP1uN6ULcD4=;
        b=PcY5dXVb97ki224D0B64TFB1nWJvDEA8DS1t1uMfCWmdj3sJMGuaS/DHsFpDNxZHzX
         n36Ko+aue6wt66roBtioVh7Owe42UuCiu2AYFDv1s/27f847EHRT6WRLCtikhQ3QlSyE
         F65nJ/Nd9XoI8B4KW6iBjgDxZf/tThrdljt3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oPLWL8Hh6dyljVbGJTzdQznEc5dQ4dVutP1uN6ULcD4=;
        b=Y2ZmJqb3TNW7nuvvarbH+yFQJFujlOfGPnLwJEL5i2uk5woojRS1s+s554G80RIevh
         /+CA2QNH6RPauUfB6eaUxImAYYc/mF7tKe+mYM6faDgOLfADrz+Uw1/GjRh3SiwuMK8L
         tDEtupNDQ/fLdVw6FbmO8a7HByvgV+HhxU2Y2HX34RvrgNPBN9rmMVXh7gWA+ASEBTaH
         5BMcKw2NWj/wKMdyFKdmYd7lnm4PEeWli995QH9ksvBXMNXcu2fRIuTxq39dmaV7c2eR
         BEMwCKSGSZvlH0YuoNXU72vnIDirafDOYdwirOQDNnGWONpH6+Hu8rWVG8R1LNY10Duq
         CR5Q==
X-Gm-Message-State: ACrzQf1dbijLByZZU7DPKxTl9hCSMBTeQBzv05n7dLX2YlIE6uscSvRq
        CpmQuPnrbnNoceafYI8EZ0ejmRMf3EF9WNNegO1/mYcZTUY=
X-Google-Smtp-Source: AMsMyM6R7DRTXamZk6f5S/2bk+3wN+dxqs5pgGVnqSj12Ek1yLlVyAs7j7hZlW82fVociNddk+P36V+ewCpZnO5GOew=
X-Received: by 2002:a17:90b:4f8d:b0:202:dd39:c03a with SMTP id
 qe13-20020a17090b4f8d00b00202dd39c03amr36415555pjb.71.1664186948648; Mon, 26
 Sep 2022 03:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <6c0155abdd7179336bcf2c59654d04a6611fb08c.1662552152.git.vinayak.yadawad@broadcom.com>
In-Reply-To: <6c0155abdd7179336bcf2c59654d04a6611fb08c.1662552152.git.vinayak.yadawad@broadcom.com>
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Date:   Mon, 26 Sep 2022 15:38:56 +0530
Message-ID: <CAMLe8U-BLCaFjBgpQ833aSwaXNbdSMGAZ0k5hs5C3B9UxyutOA@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] cfg80211: Update Transition Disable policy during
 port authorization
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f19f0205e991b727"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f19f0205e991b727
Content-Type: text/plain; charset="UTF-8"

Hi Johannes,

Could you please review the change addressing the review comments for
the earlier version of patch.

On Wed, Sep 7, 2022 at 6:15 PM Vinayak Yadawad
<vinayak.yadawad@broadcom.com> wrote:
>
> In case of 4way handshake offload, transition disable policy
> updated by the AP during EAPOL 3/4 is not updated to the upper layer.
> This results in mismatch between transition disable policy
> between the upper layer and the driver. This patch addresses this
> issue by updating transition disable policy as part of port
> authorization indication.
>
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  |  2 +-
>  include/net/cfg80211.h                               |  4 +++-
>  include/uapi/linux/nl80211.h                         |  3 +++
>  net/wireless/core.h                                  |  5 ++++-
>  net/wireless/nl80211.c                               |  7 ++++++-
>  net/wireless/nl80211.h                               |  3 ++-
>  net/wireless/sme.c                                   | 12 ++++++++----
>  net/wireless/util.c                                  |  3 ++-
>  8 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index db45da33adfd..ed18d1784521 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -6028,7 +6028,7 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
>         brcmf_dbg(CONN, "Report roaming result\n");
>
>         if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X && profile->is_ft) {
> -               cfg80211_port_authorized(ndev, profile->bssid, GFP_KERNEL);
> +               cfg80211_port_authorized(ndev, profile->bssid, NULL, 0, GFP_KERNEL);
>                 brcmf_dbg(CONN, "Report port authorized\n");
>         }
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 908d58393484..a4285e139d8f 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -7659,6 +7659,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>   *
>   * @dev: network device
>   * @bssid: the BSSID of the AP
> + * @td_bitmap: transition disable policy
> + * @td_bitmap_len: Length of transition disable policy
>   * @gfp: allocation flags
>   *
>   * This function should be called by a driver that supports 4 way handshake
> @@ -7669,7 +7671,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>   * indicate the 802.11 association.
>   */
>  void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
> -                             gfp_t gfp);
> +                             const u8* td_bitmap, u8 td_bitmap_len, gfp_t gfp);
>
>  /**
>   * cfg80211_disconnected - notify cfg80211 that connection was dropped
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index ffb7c573e299..c81cdc6d6c86 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2741,6 +2741,8 @@ enum nl80211_commands {
>   *     When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
>   *     timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
>   *     the incoming frame RX timestamp.
> + * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
> + *  (re)associations.
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3268,6 +3270,7 @@ enum nl80211_attrs {
>
>         NL80211_ATTR_TX_HW_TIMESTAMP,
>         NL80211_ATTR_RX_HW_TIMESTAMP,
> +       NL80211_ATTR_TD_BITMAP,
>
>         /* add attributes here, update the policy in nl80211.c */
>
> diff --git a/net/wireless/core.h b/net/wireless/core.h
> index 775e16cb99ed..af85d8909935 100644
> --- a/net/wireless/core.h
> +++ b/net/wireless/core.h
> @@ -271,6 +271,8 @@ struct cfg80211_event {
>                 } ij;
>                 struct {
>                         u8 bssid[ETH_ALEN];
> +                       const u8 *td_bitmap;
> +                       u8 td_bitmap_len;
>                 } pa;
>         };
>  };
> @@ -409,7 +411,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
>                         bool wextev);
>  void __cfg80211_roamed(struct wireless_dev *wdev,
>                        struct cfg80211_roam_info *info);
> -void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid);
> +void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
> +                               const u8 *td_bitmap, u8 td_bitmap_len);
>  int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
>                               struct wireless_dev *wdev);
>  void cfg80211_autodisconnect_wk(struct work_struct *work);
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 2705e3ee8fc4..87e95f34d9b2 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -17841,7 +17841,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
>  }
>
>  void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
> -                                 struct net_device *netdev, const u8 *bssid)
> +                                 struct net_device *netdev, const u8 *bssid,
> +                                 const u8 *td_bitmap, u8 td_bitmap_len)
>  {
>         struct sk_buff *msg;
>         void *hdr;
> @@ -17861,6 +17862,10 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
>             nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
>                 goto nla_put_failure;
>
> +       if ((td_bitmap_len > 0) && td_bitmap)
> +               if (nla_put(msg, NL80211_ATTR_TD_BITMAP, td_bitmap_len, td_bitmap))
> +                       goto nla_put_failure;
> +
>         genlmsg_end(msg, hdr);
>
>         genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
> diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
> index 855d540ddfb9..ba9457e94c43 100644
> --- a/net/wireless/nl80211.h
> +++ b/net/wireless/nl80211.h
> @@ -83,7 +83,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
>                          struct net_device *netdev,
>                          struct cfg80211_roam_info *info, gfp_t gfp);
>  void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
> -                                 struct net_device *netdev, const u8 *bssid);
> +                                 struct net_device *netdev, const u8 *bssid,
> +                                 const u8 *td_bitmap, u8 td_bitmap_len);
>  void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
>                                struct net_device *netdev, u16 reason,
>                                const u8 *ie, size_t ie_len, bool from_ap);
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index 27fb2a0c4052..42e750a18320 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -1234,7 +1234,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>  }
>  EXPORT_SYMBOL(cfg80211_roamed);
>
> -void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
> +void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
> +                                       const u8 *td_bitmap, u8 td_bitmap_len)
>  {
>         ASSERT_WDEV_LOCK(wdev);
>
> @@ -1247,11 +1248,11 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
>                 return;
>
>         nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
> -                                    bssid);
> +                                    bssid, td_bitmap, td_bitmap_len);
>  }
>
>  void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
> -                             gfp_t gfp)
> +                             const u8 *td_bitmap, u8 td_bitmap_len, gfp_t gfp)
>  {
>         struct wireless_dev *wdev = dev->ieee80211_ptr;
>         struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
> @@ -1261,12 +1262,15 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
>         if (WARN_ON(!bssid))
>                 return;
>
> -       ev = kzalloc(sizeof(*ev), gfp);
> +       ev = kzalloc(sizeof(*ev) + td_bitmap_len, gfp);
>         if (!ev)
>                 return;
>
>         ev->type = EVENT_PORT_AUTHORIZED;
>         memcpy(ev->pa.bssid, bssid, ETH_ALEN);
> +       ev->pa.td_bitmap = ((u8 *)ev) + sizeof(*ev);
> +       ev->pa.td_bitmap_len = td_bitmap_len;
> +       memcpy((void *)ev->pa.td_bitmap, td_bitmap, td_bitmap_len);
>
>         /*
>          * Use the wdev event list so that if there are pending
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 2c127951764a..42e7fce3184b 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -988,7 +988,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
>                         __cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
>                         break;
>                 case EVENT_PORT_AUTHORIZED:
> -                       __cfg80211_port_authorized(wdev, ev->pa.bssid);
> +                       __cfg80211_port_authorized(wdev, ev->pa.bssid, ev->pa.td_bitmap,
> +                                              ev->pa.td_bitmap_len);
>                         break;
>                 }
>                 wdev_unlock(wdev);
> --
> 2.32.0
>

--000000000000f19f0205e991b727
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
RY30ttFfLGgUxOvRzd7UPGXmjiRyV20Vv+kGag5aTueKGHUv49TWypHgJc4PX8L9y3VouEhbWmGb
bwuQjKELfovabHM5PWUVRda3t72kGFVMkIZ65u6DCdyjPFCUGnMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUS9fHYxc9qAJz
gfBKun+P2LFASWAwDQYJKoZIhvcNAQELBQADggEBABiMQNJRdQCxXwqwqb49w0ZXCxsSrs3gS4NA
G3H9oJuvzJ8ml5Z9l9p9PGPHcrmc/BdFjIIu/wQftGETAf1+W6AvxXqYmA2flaogebRueqCMQJiy
xbJlOSry64AGOzHYULvI70tt9woEYgSx3I703b7c8o7eWCiU267y/WNzH+MpZ12h9q0Jwhw8uH9S
BTl38q8FNdCLAiM1OD+blhu7LqMLVaAEEeoUGhRxdNkvMGss1Z7/ZefenAfm9IpiaGR0PQhBwI7c
spqD/wIJUULcXiaj0eatDUjsrx3QN9OZOh3iubCt0uBoxCQUGuvxqd3Qz4FVKMSzEIzs8v/hwR+T
nTkxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxIxd7r
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKG5ii3EmhCRAfeMxOob
rCAUzBn+DcRyFnSiBIQcWVFIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDkyNjEwMDkwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMWsedOt5ztjJWXXPiDtPZs77Xv6Cy5Taq7Z/E
0qOAYtkE1NBo5hxEk3RaJ7RVzuAw+G/oqspbDhh0cfUzIgxa/9pgxkNSgBqYcH7AFGy5dk0hMWnE
0r5+/ucHPlKaMCBRej/t3Og4jFICwZ3yy2E6sg7sfpuzXKFGALBCVgB34LEa2Y2O8EHWeRxN2VGE
Iu68WQ/cNz5rh4y/onpkChZnXQ3C6E+FDOZ/Wndotub15FOQNghKL9dXm5PJ9vXt4F790R1nQWY/
u3sssfZQ0vJ8K2G8WO022ArTHwT7y8MYSEAMNlnTYj3wjgUFMP6XQjKVnFWjGQE3natbbXNQpWUc
--000000000000f19f0205e991b727--
